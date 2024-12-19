/*
    A 32-bit GPIO Port (APB)
*/

module apb_gpio(
    input   wire        PCLK,
    input   wire        PRESETn,

    input   wire [31:0] PADDR,
    input   wire        PWRITE,
    input   wire        PENABLE,
    input   wire        PSEL,
    input   wire [31:0] PWDATA,

    output  wire        PREADY,
    output  wire [31:0] PRDATA,

    input  wire [31:0]  GPIO_IN,
    output wire [31:0]  GPIO_OUT,
    output wire [31:0]  GPIO_OE
);

    localparam  DATA_REG_OFF = 16'h0000,
                DIR_REG_OFF  = 16'h0004;


    wire apb_access = PSEL & PENABLE;
    wire apb_we     = PWRITE & apb_access; 
    wire apb_re     = ~PWRITE & apb_access;

    wire DATA_REG_sel = (PADDR[15:0] == DATA_REG_OFF);
    wire DIR_REG_sel  = (PADDR[15:0] == DIR_REG_OFF);

    reg [31:0] DATAO_REG, DIR_REG;
    reg [31:0] DATAI_REG_d, DATAI_REG;

    always @(posedge PCLK or negedge PRESETn) begin
        if (~PRESETn) begin
            DATAO_REG <= 32'h0;
            DIR_REG <= 32'h0;
        end else if (apb_we) begin
            if (DATA_REG_sel) DATAO_REG <= PWDATA;
            if (DIR_REG_sel)  DIR_REG <= PWDATA;
        end
    end

    always @(posedge PCLK or negedge PRESETn) begin
        if (~PRESETn) begin
            DATAI_REG_d <= 32'h0;
            DATAI_REG <= 32'h0;
        end else begin
            DATAI_REG_d <= GPIO_IN;
            DATAI_REG <= DATAI_REG_d;
        end
    end

    assign PRDATA = DATA_REG_sel ? DATAI_REG :
                    DIR_REG_sel  ? DIR_REG :
                    32'hDEADBEEF;

    assign GPIO_OUT = DATAO_REG;
    assign GPIO_OE  = DIR_REG;

    assign PREADY = 1'b1;

endmodule
