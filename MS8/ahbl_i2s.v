module ahbl_i2s #(parameter WSZ = 32) (
    input   wire        HCLK,
    input   wire        HRESETn,
    input   wire [31:0] HADDR,
    input   wire [1:0]  HTRANS,
    input   wire        HWRITE,
    input   wire        HSEL,
    input   wire [31:0] HWDATA,
    output  wire [31:0] HRDATA,
    output  wire        HREADYOUT,

    // I2S-specific ports
    input   wire        clk,     // External I2S clock
    input   wire        rst_n,   // External reset for I2S
    input   wire        mode,    // I2S mode
    input   wire        tick,    // I2S tick
    input   wire        SD,      // I2S data in
    output  wire        SCK,     // I2S clock out
    output  wire        WS       // Word select signal
);

    // Internal signals
    reg [31:0] sample_reg;
    reg        rdy_reg;

    // Address decoding
    wire sample_sel = (HADDR[23:0] == 24'h00);  // Address for reading sample
    wire rdy_sel    = (HADDR[23:0] == 24'h04);  // Address for reading ready status
    wire ahb_rd     = HTRANS[1] & HSEL & ~HWRITE;  // AHB read transaction

    // Connect the I2S module
    wire [WSZ-1:0] i2s_sample;
    wire           i2s_rdy;

    i2s #(.WSZ(WSZ)) i2s_inst (
        .clk(clk),
        .rst_n(rst_n),
        .mode(mode),
        .tick(tick),
        .sample(i2s_sample),
        .rdy(i2s_rdy),
        .SD(SD),
        .SCK(SCK),
        .WS(WS)
    );

    // Capture I2S output in AHB registers
    always @(posedge HCLK or negedge HRESETn) begin
        if (!HRESETn) begin
            sample_reg <= 0;
            rdy_reg <= 0;
        end else begin
            if (ahb_rd & sample_sel)  // Read sample
                sample_reg <= i2s_sample;

            if (ahb_rd & rdy_sel)  // Read ready status
                rdy_reg <= i2s_rdy;
        end
    end

    // Output MUX for HRDATA
    assign HRDATA = (sample_sel) ? sample_reg :
                    (rdy_sel)    ? {31'b0, rdy_reg} :
                                   32'hBADDBEEF;

    // Always ready
    assign HREADYOUT = 1'b1;

endmodule
