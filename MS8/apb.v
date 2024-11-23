module apb(
    input wire          PCLK,
    input wire          PRESETn,
    input wire          PWRITE,
    input wire [31:0]   PWDATA,
    input wire [31:0]   PADDR,
    input wire          PENABLE,
    output wire         PREADY,
    output wire [31:0]  PRDATA,

    input  wire [31:0]  GPIO_IN,
    output wire [31:0]  GPIO_OUT,
    output wire [31:0]  GPIO_OE
);

    // Slave Decoding/Selection
    // The 3rd Most Significant Byte is used for decoding
    wire PSEL_S0 = (PADDR[23:16] == 8'h00); 
    wire PSEL_S1 = (PADDR[23:16] == 8'h01);

    wire        PREADY_S0;
    wire [31:0] PRDATA_S0;
    wire        PREADY_S1;
    wire [31:0] PRDATA_S1;

    // Slave 0 Instance (Generic APB Slave)
    apb_slave APB_S0 (
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PWRITE(PWRITE),
        .PWDATA(PWDATA),
        .PADDR(PADDR),
        .PENABLE(PENABLE),
        .PSEL(PSEL_S0),
        .PREADY(PREADY_S0),
        .PRDATA(PRDATA_S0)
    );

    // GPIO Slave Instance
    apb_gpio APB_GPIO (
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PWRITE(PWRITE),
        .PWDATA(PWDATA),
        .PADDR(PADDR),
        .PENABLE(PENABLE),
        .PSEL(PSEL_S1),
        .PREADY(PREADY_S1),
        .PRDATA(PRDATA_S1),
        .GPIO_IN(GPIO_IN),
        .GPIO_OUT(GPIO_OUT),
        .GPIO_OE(GPIO_OE)
    );

    assign PREADY = (PSEL_S0 ? PREADY_S0 : 
                    (PSEL_S1 ? PREADY_S1 : 1'b1));

    assign PRDATA = (PSEL_S0 ? PRDATA_S0 : 
                    (PSEL_S1 ? PRDATA_S1 : 32'hDEADBEEF));

endmodule
