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

    output wire full

);

    localparam  CTRL_REG_OFF    = 'h00,
                DONE_REG_OFF = 'h04,
                DATA_REG_OFF = 'h08;

    // store the address phase signals
    reg [31:0]  HADDR_d;
    reg [2:0]   HSIZE_d;
    reg [1:0]   HTRANS_d;
    reg         HWRITE_d;
    reg         HSEL_d;

    wire tick, rdy, count;
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


    always @ (posedge HCLK or negedge HRESETn)
        if(~HRESETn)
            CTRL_REG <= 4'b0;
        else if(ahbl_we & CTRL_REG_SEL)
            CTRL_REG <= HWDATA[3:0];

    wire [31:0] user_CTRL_REG = {28'h0, CTRL_REG};
    wire [31:0] user_DONE_REG = {30'h0, DONE_REG};


    assign HRDATA = DATA_REG_SEL   ? DATA_REG             :  
                    CTRL_REG_SEL   ? user_CTRL_REG    :
                    DONE_REG_SEL   ? user_DONE_REG    :
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
        .WS(WS)
    );



    // fifo logic

    //note wr is already assigned to rdy so when rdy it will know to begin writing

    always @(posedge HCLK) begin
        if(!HRESETn) begin
            rd     <= 'h0;
            flush    <= 'h00;
            wdata    <= 'h0;
        end
        //REMOVE THE BELOW LATER THIS IS JUST SO I CAN TEST THE ISR. IT INSTA EMPTIES THE FIFO WE DONT WANT THAT
        else begin
            if(full) begin 
                flush <= 1;
            end
            else if (flush) begin
                flush <=0;
            end
        end
    end

    always@(posedge HCLK, negedge HRESETn) begin
        if(wr) begin //note this will take the left and right sample, we can & with !WS to take the left sample only, Ill leave it this way for now
            wdata = DATA_REG;
        end
    end
    

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