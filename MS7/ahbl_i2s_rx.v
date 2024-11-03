module ahbl_i2s_rx (
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

    input  wire        rx,      
    output wire        ws,      
    output wire        i2s_clk, 
    output wire [63:0] rx_data   
);

    localparam MODE_ADDR = 'h00;
    //localparam DATA_ADDR = 'h04;

    

    reg [31:0] HADDR_d;
    reg [1:0]  HTRANS_d;
    reg        HWRITE_d;
    reg        HSEL_d;
    reg [1:0]  MODE_reg;  
    reg [31:0]  DATA_reg;  


    wire MODE_sel = (HADDR_d[23:0] == MODE_ADDR);
    //wire DATA_sel = (HADDR_d[23:0] == DATA_ADDR);

    always @(posedge HCLK) begin
        if (!HRESETn) begin
            HADDR_d   <= 32'h0;
            HSEL_d    <= 1'b0;
            HWRITE_d  <= 1'b0;
            HTRANS_d  <= 2'b0;
        end else if (HREADY) begin
            HADDR_d   <= HADDR;
            HSEL_d    <= HSEL;
            HWRITE_d  <= HWRITE;
            HTRANS_d  <= HTRANS;
        end
    end

    // 00 --> left stereo
    // 01 --> right stereo
    // 10 --> full stereo 
    // always @(posedge HCLK) begin
    //     if (!HRESETn) begin
    //         MODE_reg <= 2'b00;  //default will be the left stereo
    //     end else if (HREADY && HSEL && HWRITE && MODE_sel) begin
    //         MODE_reg <= HWDATA[1:0]; 
    //     end
    // end

    assign HRDATA = (MODE_sel) ? rx_data[45:14] :   // left stereo (bits 0 to 31)
                    // (MODE_reg == 2'b01) ? rx_data[63:32] :  // right stereo (bits 32 to 63)
                    // (MODE_reg == 2'b10) ? rx_data[63:0] :   // full stereo (bits 0 to 63)
                    32'hDEADBEEF;                           

    // Ready Output (Always Ready in this case)
    assign HREADYOUT = 1'b1;

    // I2S Receiver Instance
    i2s_rx i2s_receiver (
        .clk(HCLK),
        .rst_n(HRESETn),
        .rx(rx),
        .ws(ws),
        .i2s_clk(i2s_clk),
        .rx_data(rx_data)
    );

endmodule
