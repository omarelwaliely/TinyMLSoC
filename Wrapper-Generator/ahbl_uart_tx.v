`default_nettype none

/*
    ahbl_i2s_AHBL Wrapper
    Description: AHB-Lite Wrapper for I2S Module
    Auto-generated on 2024-11-20 12:21:41
*/

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
    input wire SD,
    output wire SCK,
    output wire WS,
    output wire [31:0] sample,
    output wire rdy
);

    // Sticky Signals
    reg [31:0] HADDR_d;
    reg [1:0] HTRANS_d;
    reg HWRITE_d;
    reg HSEL_d;
    reg SCK_d;
    reg WS_d;

    // Sticky Logic
    always @(posedge HCLK or negedge HRESETn) begin
        if (~HRESETn)
            HADDR_d <= 32'b0;
        else
            HADDR_d <= HADDR;
    end
    always @(posedge HCLK or negedge HRESETn) begin
        if (~HRESETn)
            HTRANS_d <= 2'b0;
        else
            HTRANS_d <= HTRANS;
    end
    always @(posedge HCLK or negedge HRESETn) begin
        if (~HRESETn)
            HWRITE_d <= 1'b0;
        else
            HWRITE_d <= HWRITE;
    end
    always @(posedge HCLK or negedge HRESETn) begin
        if (~HRESETn)
            HSEL_d <= 1'b0;
        else
            HSEL_d <= HSEL;
    end
    always @(posedge HCLK or negedge HRESETn) begin
        if (~HRESETn)
            SCK_d <= 1'b0;
        else
            SCK_d <= SCK;
    end
    always @(posedge HCLK or negedge HRESETn) begin
        if (~HRESETn)
            WS_d <= 1'b0;
        else
            WS_d <= WS;
    end

    // Address phase signals
    reg [31:0] HADDR_d;
    reg [1:0]  HTRANS_d;
    reg        HWRITE_d, HSEL_d;

    always @(posedge HCLK or negedge HRESETn) begin
        if (~HRESETn) begin
            HADDR_d  <= 32'b0;
            HTRANS_d <= 2'b0;
            HWRITE_d <= 1'b0;
            HSEL_d   <= 1'b0;
        end else if (HREADY) begin
            HADDR_d  <= HADDR;
            HTRANS_d <= HTRANS;
            HWRITE_d <= HWRITE;
            HSEL_d   <= HSEL;
        end
    end

    wire ahbl_we = HTRANS_d[1] & HSEL_d & HWRITE_d;
    wire ahbl_re = HTRANS_d[1] & HSEL_d & ~HWRITE_d;

    // Register Declarations
    reg [0:0] CTRL_REG;
    reg [0:0] STATUS_REG;
    reg [31:0] SAMPLE_REG;

    // Signal Selection Logic
    wire CTRL_sel = (HADDR_d[23:0] == CTRL_REG_OFF);
    wire STATUS_sel = (HADDR_d[23:0] == STATUS_REG_OFF);
    wire SAMPLE_sel = (HADDR_d[23:0] == SAMPLE_REG_OFF);

    // Register Offsets
    localparam CTRL_REG_OFF = 32'h00;
    localparam STATUS_REG_OFF = 32'h04;
    localparam SAMPLE_REG_OFF = 32'h08;

    // Register Logic
    always @(posedge HCLK or negedge HRESETn) begin
        if (~HRESETn)
            CTRL_REG <= 0; // Default reset value
        else if (ahbl_we & CTRL_sel)
            CTRL_REG <= HWDATA[0:0];
    end
    // STATUS_REG is read-only
    // SAMPLE_REG is read-only

    // Read Data Logic
    assign HRDATA =
        CTRL_sel ? {32-1'b0, CTRL_REG} :
        STATUS_sel ? {32-1'b0, STATUS_REG} :
        SAMPLE_sel ? {32-32'b0, SAMPLE_REG} :
        32'hBADDBEEF;

    assign HREADYOUT = 1'b1;

    // Submodule Instance: i2s
    i2s i2s_instance (
        .clk(HCLK),
        .rst_n(HRESETn),
        .mode(CTRL_REG[0]),
        .tick(HWDATA[0]),
        .sample(SAMPLE_REG),
        .rdy(STATUS_REG[0]),
        .SD(SD),
        .SCK(SCK),
        .WS(WS)
    );

endmodule
