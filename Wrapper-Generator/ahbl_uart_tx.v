`default_nettype none

/*
    ahbl_uart_tx_AHBL Wrapper
    Description: AHB-Lite Wrapper for UART Transmitter
    Auto-generated on 2024-11-20 04:53:05
*/

module ahbl_uart_tx (
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
    output wire        tx
);

    // Register offsets
    localparam CTRL_REG_OFF = 32'h00;
    localparam BAUDDIV_REG_OFF = 32'h04;
    localparam STATUS_REG_OFF = 32'h08;
    localparam DATA_REG_OFF = 32'h0C;

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
    reg [1:0] CTRL_REG;
    reg [15:0] BAUDDIV_REG;
    reg [0:0] STATUS_REG;
    reg [7:0] DATA_REG;

    // Signal Selection Logic
    wire CTRL_sel = (HADDR_d[23:0] == CTRL_REG_OFF);
    wire BAUDDIV_sel = (HADDR_d[23:0] == BAUDDIV_REG_OFF);
    wire STATUS_sel = (HADDR_d[23:0] == STATUS_REG_OFF);
    wire DATA_sel = (HADDR_d[23:0] == DATA_REG_OFF);

    // Register Logic
    always @(posedge HCLK or negedge HRESETn) begin
        if (~HRESETn)
            CTRL_REG <= 0; // Default reset value
        else if (ahbl_we & CTRL_sel)
            CTRL_REG <= HWDATA[1:0];
    end
    always @(posedge HCLK or negedge HRESETn) begin
        if (~HRESETn)
            BAUDDIV_REG <= 0; // Default reset value
        else if (ahbl_we & BAUDDIV_sel)
            BAUDDIV_REG <= HWDATA[15:0];
    end
    // STATUS_REG is read-only
    always @(posedge HCLK or negedge HRESETn) begin
        if (~HRESETn)
            DATA_REG <= 0; // Default reset value
        else if (ahbl_we & DATA_sel)
            DATA_REG <= HWDATA[7:0];
    end

    // Read Data Logic
    assign HRDATA =
        CTRL_sel ? {32-2'b0, CTRL_REG} :
        BAUDDIV_sel ? {32-16'b0, BAUDDIV_REG} :
        STATUS_sel ? {32-1'b0, STATUS_REG} :
        DATA_sel ? {32-8'b0, DATA_REG} :
        32'hBADDBEEF;

    assign HREADYOUT = 1'b1;

    // Submodule Instance: uart_tx
    uart_tx uart_tx_instance (
        .clk(HCLK),
        .rst_n(HRESETn),
        .en(CTRL_REG[0]),
        .start(CTRL_REG[1]),
        .data(DATA_REG),
        .baud_div(BAUDDIV_REG),
        .tx(tx),
        .done(done)
    );

endmodule
