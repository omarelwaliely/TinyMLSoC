`default_nettype none

module ahbl_i2s (
    // AHB-Lite Interface
    input  wire        HCLK,
    input  wire        HRESETn,
    input  wire [31:0] HADDR,
    input  wire [1:0]  HTRANS,
    input  wire        HWRITE,
    input  wire [2:0]  HSIZE,
    input  wire [31:0] HWDATA,
    input  wire        HSEL,
    input  wire        HREADY,

    output wire [31:0] HRDATA,
    output wire        HREADYOUT,

    input  wire        SD,
    output wire        SCK,
    output wire        WS,
    output wire vad_active,

    input wire DMAC_interaction,
    output wire IRQ

);

    localparam  CTRL_REG_OFF    = 'h00,
                DONE_REG_OFF = 'h04,
                DATA_REG_OFF = 'h08,
                FIFO_STATUS_REG_OFF = 'h0C, 
                FIFO_DATA_REG_OFF = 'h10; 

    // store the address phase signals
    reg [31:0]  HADDR_d;
    reg [2:0]   HSIZE_d;
    reg [1:0]   HTRANS_d;
    reg         HWRITE_d;
    reg         HSEL_d;

    wire tick, rdy, count,full;
    wire [31:0] sample;

    localparam DW = 32;  
    localparam AW = 4;

    reg rdy_sync1, rdy_sync2;


    reg rd,flush;
    wire wr = rdy;
    wire empty;
    wire [DW-1:0]   rdata;
    reg [DW-1:0]   wdata;
    wire [AW-1:0]   level; //not really used in this case as far as I can tell 

    wire CTRL_REG_SEL       = (HADDR_d[7:0] == CTRL_REG_OFF);
    wire DONE_REG_SEL       = (HADDR_d[7:0] == DONE_REG_OFF);
    wire DATA_REG_SEL       = (HADDR_d[7:0] == DATA_REG_OFF);
    wire FIFO_STATUS_REG_SEL       = (HADDR_d[7:0] == FIFO_STATUS_REG_OFF);
    wire FIFO_DATA_REG_SEL       = (HADDR_d[7:0] == FIFO_DATA_REG_OFF);



    

    wire ahbl_we            = HTRANS_d[1] & HSEL_d & HWRITE_d;
    wire ahbl_re            = HTRANS_d[1] & HSEL_d & !HWRITE_d;

    always @(posedge HCLK) begin
        if(!HRESETn) begin
            HADDR_d     <= 'h0;
            HSIZE_d     <= 'h0;
            HTRANS_d    <= 'h00;
            HWRITE_d    <= 'h0;
            HSEL_d      <= 'h00;
        end else if(HREADY) begin
            HADDR_d     <= HADDR;
            HSIZE_d     <= HSIZE;
            HTRANS_d    <= HTRANS;
            HWRITE_d    <= HWRITE;
            HSEL_d      <= HSEL;
        end
    end


    reg [ 3:0]  CTRL_REG;
    reg [31:0]  DATA_REG;
    reg [1:0]  DONE_REG;
    reg [31:0]  FIFO_DATA_REG;




    always @ (posedge HCLK or negedge HRESETn)
        if(~HRESETn)
            CTRL_REG <= 4'b0;
        else if(ahbl_we & CTRL_REG_SEL)
            CTRL_REG <= HWDATA[3:0];
    
    

    wire [31:0] user_CTRL_REG = {28'h0, CTRL_REG};
    wire [31:0] user_DONE_REG = {30'h0, DONE_REG};
    wire [31:0] user_FIFO_STATUS_REG = {31'h0, empty};



    assign HRDATA = DMAC_interaction ? FIFO_DATA_REG :
                    DATA_REG_SEL   ? DATA_REG             :  
                    CTRL_REG_SEL   ? user_CTRL_REG    :
                    DONE_REG_SEL   ? user_DONE_REG    :
                    FIFO_STATUS_REG_SEL   ? user_FIFO_STATUS_REG    :
                    FIFO_DATA_REG_SEL  ? FIFO_DATA_REG    :


                    32'hBADDBEEF;


   always @(posedge HCLK or negedge HRESETn) begin
        if (!HRESETn) begin
            rdy_sync1 <= 1'b0;
            rdy_sync2 <= 1'b0;
        end else begin
            rdy_sync1 <= rdy;       // First stage
            rdy_sync2 <= rdy_sync1; // Second stage
        end
    end
    
    always @(posedge HCLK or negedge HRESETn) begin
        if (!HRESETn)
            DONE_REG <= 2'b00;
        else if (rdy_sync2)  // Prioritize `rdy`
            DONE_REG <= {rdy_sync2, WS};
        else if (ahbl_re && DONE_REG_SEL)  // Clear `DONE_REG` on AHB read
            DONE_REG <= {1'b0, WS};
    end

    always@(posedge HCLK, negedge HRESETn) begin
            if(!HRESETn)
                DATA_REG<=32'd0;
            else
                if (ahbl_re && DATA_REG_SEL)
                    DATA_REG<=DATA_REG;
                else if(rdy)
                    DATA_REG <= sample;
    end

   


    assign HREADYOUT = 1'b1; // Always ready



    i2s i2s_wrap(
        .clk(HCLK),
        .rst_n(HRESETn),
        .data(sample),
        .done(rdy),
        .en(CTRL_REG[0]),
        .DIN(SD),
        .BCLK(SCK),
        .WS(WS),
        .vad_active(vad_active)
    );



    // fifo logic

    //note wr is already assigned to rdy so when rdy it will know to begin writing

    // always @(posedge HCLK) begin
    //     if(!HRESETn) begin
    //         rd     <= 'h0;
    //         flush    <= 'h00;
    //         wdata    <= 'h0;
    //     end
    // end

    // always@(posedge HCLK, negedge HRESETn) begin
    //     if(wr & !WS) begin //note this will take the left and right sample, we can & with !WS to take the left sample only, Ill leave it this way for now
    //         wdata <= DATA_REG;
    //     end
    // end
    always @(posedge HCLK or negedge HRESETn) begin
    if (!HRESETn) begin
        rd     <= 1'b0;
        flush  <= 1'b0;
        wdata  <= 32'b0;
    end else begin
        if (wr & !WS) begin
            wdata <= DATA_REG; // Use non-blocking assignment
        end
    end
end



    always@(posedge HCLK, negedge HRESETn) begin
            if(!HRESETn) begin
                FIFO_DATA_REG<=32'd0;
            end
            else begin
                if ((ahbl_re && FIFO_DATA_REG_SEL) | ahbl_re && DMAC_interaction)begin
                    rd<=1;
                    FIFO_DATA_REG<=rdata;
                end
                else begin
                    // FIFO_DATA_REG <= rdata;
                    rd<=0;
                end
            end
    end



    //interrupt logic (I make it pulse once if full but for now the logic states that the interrupt wont occur again, until the fifo is empty then full)

    reg fifo_full_d;       
    reg fifo_was_empty; 
    reg irq_reg;         

    always @(posedge HCLK or negedge HRESETn) begin
        if (!HRESETn) begin
            fifo_was_empty <= 1'b1; 
        end else if (empty) begin
            fifo_was_empty <= 1'b1;
        end else if (full) begin
            fifo_was_empty <= 1'b0; 
        end
    end

    always @(posedge HCLK or negedge HRESETn) begin
        if (!HRESETn) begin
            fifo_full_d <= 1'b0;
        end else begin
            fifo_full_d <= full;
        end
    end

    always @(posedge HCLK or negedge HRESETn) begin
        if (!HRESETn) begin
            irq_reg <= 1'b0;
        end else if (full && !fifo_full_d && fifo_was_empty) begin
            irq_reg <= 1'b1; // Trigger IRQ when full rises and FIFO was empty before
        end else begin
            irq_reg <= 1'b0; // Clear IRQ after one clock cycle
        end
    end

    assign IRQ = irq_reg;


    
    //32 bit width 16 depth
    aucohl_fifo #(DW, AW) fifo_inst ( 
        .clk(HCLK),
        .rst_n(HRESETn),
        .rd(rd),
        .wr(wr),
        .flush(flush),
        .wdata(wdata),
        .empty(empty),
        .full(full),
        .rdata(rdata),
        .level(level)
    );



endmodule