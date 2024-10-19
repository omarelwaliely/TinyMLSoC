/*
    A simple SoC
        - 1 CPU : Hazard2
        - 2 Memories : 8kbytes Data memory and 8kbytes Program memory
        - 1 32-bit GPIO Port

    The Memory Map:
        - 0x0000_0000 - 0x0000_1FFF : Program Memory
        - 0x2000_2000 - 0x2000_1FFF : Data Memory
        - 0x4000_0000 : GPIO Port A
        - 0x5000_0000 : GPIO Port B
        - 0x5000_0000 : GPIO Port C
*/

module Hazard2_SoC (
    input wire          HCLK,
    input wire          HRESETn,
    // output wire [2:0]   LED_out,
    output wire [31:0]  GPIO_OUT_A,
    output wire [31:0]  GPIO_OE_A,
    input wire [31:0]   GPIO_IN_A,

    output wire [31:0]  GPIO_OUT_B,
    output wire [31:0]  GPIO_OE_B,
    input wire [31:0]   GPIO_IN_B,

    output wire [31:0]  GPIO_OUT_C,
    output wire [31:0]  GPIO_OE_C,
    input wire [31:0]   GPIO_IN_C,
    output wire UART_TX


);
    // wire          HRESETn;
    // wire [31:0]  GPIO_OUT_A;
    // wire [31:0]  GPIO_OE_A;
    // wire [31:0]   GPIO_IN_A;

    wire [31:0] HADDR;
    wire [1:0]  HTRANS;
    wire [2:0] 	HSIZE;
    wire        HWRITE;
    wire [31:0] HWDATA;
    wire        HREADY;
    wire [31:0] HRDATA;

    //SPLITTER SLAVE WIRES

    wire [31:0] S0_HRDATA, S1_HRDATA, S2_HRDATA, S3_HRDATA, S4_HRDATA;
    wire        S0_HSEL, S1_HSEL, S2_HSEL, S3_HSEL, S4_HSEL;
    wire        S0_HREADYOUT, S1_HREADYOUT, S2_HREADYOUT, S3_HREADYOUT, S4_HREADYOUT;

    //GPIO SLAVE WIRES

    wire [31:0] A_HRDATA, B_HRDATA, C_HRDATA;
    wire        A_SEL, B_SEL, C_SEL;
    wire        A_HREADYOUT, B_HREADYOUT, C_HREADYOUT;




    //INSTANTIATIONS

    Hazard2 CPU (
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .HADDR(HADDR),
        .HTRANS(HTRANS),
        .HSIZE(HSIZE),
        .HWRITE(HWRITE),
        .HWDATA(HWDATA),
        .HREADY(HREADY),
        .HRDATA(HRDATA)
    );

    ahbl_uart_tx TX (
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .HADDR(HADDR),
        .HTRANS(HTRANS),
        .HSIZE(HSIZE),
        .HWRITE(HWRITE),
        .HREADY(HREADY),
        .HSEL(S3_HSEL),
        .HWDATA(HWDATA),
        .HREADYOUT(S3_HREADYOUT),
        .HRDATA(S3_HRDATA),

        .tx(UART_TX)
    );


    //MEMORY
    ahbl_rom #(.SIZE(8*1024)) PMEM (
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .HADDR(HADDR),
        .HREADY(HREADY),
        .HSEL(S0_HSEL),
        .HREADYOUT(S0_HREADYOUT),
        .HRDATA(S0_HRDATA)
    );

    ahbl_ram #(.SIZE(8*760)) DMEM (
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .HADDR(HADDR),
        .HTRANS(HTRANS),
        .HSIZE(HSIZE),
        .HWRITE(HWRITE),
        .HREADY(HREADY),
        .HSEL(S1_HSEL),
        .HWDATA(HWDATA),
        .HREADYOUT(S1_HREADYOUT),
        .HRDATA(S1_HRDATA)
    );


    //GPIOS

    ahbl_gpio GPIO_A (
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .HADDR(HADDR),
        .HTRANS(HTRANS),
        .HSIZE(HSIZE),
        .HWRITE(HWRITE),
        .HREADY(HREADY),
        .HSEL(A_SEL),
        .HWDATA(HWDATA),
        .HREADYOUT(A_HREADYOUT),
        .HRDATA(A_HRDATA),

        .GPIO_IN(GPIO_IN_A),
        .GPIO_OUT(GPIO_OUT_A),
        .GPIO_OE(GPIO_OE_A)
    );
    
    // light_control LC    (
	// .clk(HCLK),
	// .RGB_in(GPIO_OUT_A[2:0]),
	// .LED_RGB(LED_out)
    // );

    //SPLITTERS
    ahbl_splitter # ( .S0(4'h0),     // Program Memory
                        .S1(4'h2),     // Data Memory
                        .S2(4'h4),     // GPIO splitter
                        .S3(4'h5)      // UART
    ) SPLITTER (
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .HADDR(HADDR),
        .HTRANS(HTRANS),
        .HREADY(HREADY),
        .HRDATA(HRDATA),

        .S0_HSEL(S0_HSEL),
        .S0_HRDATA(S0_HRDATA),
        .S0_HREADYOUT(S0_HREADYOUT),

        .S1_HSEL(S1_HSEL),
        .S1_HRDATA(S1_HRDATA),
        .S1_HREADYOUT(S1_HREADYOUT),

        .S2_HSEL(S2_HSEL),
        .S2_HRDATA(S2_HRDATA),
        .S2_HREADYOUT(S2_HREADYOUT),

        .S3_HSEL(S3_HSEL),
        .S3_HRDATA(S3_HRDATA),
        .S3_HREADYOUT(S3_HREADYOUT)

    );

    ahbl_gpio_splitter #(.A(3'h0), 
                        .B(3'h1),
                        .C(3'h2)
    ) GPIO_SPLITTER (
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .HADDR(HADDR),
        .HTRANS(HTRANS),
        .HREADY(HREADY),
        .HRDATA(S2_HRDATA),
        .HSEL(S2_HSEL),
        .HREADYOUT(S2_HREADYOUT),

        .A_SEL(A_SEL),
        .A_HRDATA(A_HRDATA),
        .A_HREADYOUT(A_HREADYOUT),

        .B_SEL(B_SEL),
        .B_HRDATA(0),
        .B_HREADYOUT(1'b1),

        .C_SEL(C_SEL),
        .C_HRDATA(0),
        .C_HREADYOUT(1'b1)

);

endmodule
