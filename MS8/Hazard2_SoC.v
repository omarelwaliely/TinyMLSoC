/*
    A simple SoC
        - 1 CPU : Hazard2
        - 2 Memories : 8kbytes Data memory and 8kbytes Program memory
        - 1 32-bit GPIO Port

    The Memory Map:
        - 0x0000_0000 - 0x0000_1FFF : Program Memory
        - 0x2000_2000 - 0x2000_1FFF : Data Memory
        - 0x4000_0000 - GPIO Port
        - 0x5000_0000 - UART Transmitter
*/

module Hazard2_SoC (
    input wire          HCLK,
    input wire          HRESETn,
    input wire read_uart,
    // output wire         UART_TX,
    // output wire [2:0]   LED_out,
    output wire [63:0]  I2S_out,
    output wire         ws,
    output wire         i2s_clk,
        // Expose AHB signals for verification
    output wire [31:0]  HADDR,
    output wire  [2:0] 	HSIZE,
    output wire [1:0]   HTRANS,
    output wire         HWRITE,
    output wire [31:0]  HWDATA,
    output wire         HREADY,
    output wire [31:0]  HRDATA
);

//----------------------------------
// APB Bridge and Peripheral Signals
//----------------------------------
    wire [31:0] PRDATA;
    wire [31:0] PWDATA;
    wire [31:0] PADDR;
    wire        PENABLE;
    wire        PWRITE;
    wire        PREADY;
    wire        PCLK;
    wire        PRESETn;
//---------------------------------

    wire UART_TX;
    wire [2:0] LED_out;
    wire [31:0]  GPIO_OUT_A;
    wire [31:0]  GPIO_OE_A;
    wire [31:0]   GPIO_IN_A;

    wire [31:0]  GPIO_OUT_D;
    wire [31:0]  GPIO_OE_D;
    wire [31:0]   GPIO_IN_D;

    wire [31:0]  GPIO_OUT;
    wire [31:0]  GPIO_OE;
    wire [31:0]  GPIO_IN;
    // wire          HRESETn;
    wire [31:0] TIMER_OUT;
    wire ws_out;

    //GPIO SLAVE WIRES
    wire [31:0] A_HRDATA, B_HRDATA, C_HRDATA, timer_HRDATA, i2s_HRDATA;
    wire        A_SEL, B_SEL, C_SEL, timer_SEL, i2s_SEL;
    wire        A_HREADYOUT, B_HREADYOUT, C_HREADYOUT, timer_HREADYOUT, i2s_HREADYOUT;
    

//------------------------


    //SPLITTER SLAVE WIRES
    wire [31:0] S0_HRDATA, S1_HRDATA, S2_HRDATA, S3_HRDATA, S4_HRDATA, S5_HRDATA;
    wire        S0_HSEL, S1_HSEL, S2_HSEL, S3_HSEL, S4_HSEL, S5_HSEL;
    wire        S0_HREADYOUT, S1_HREADYOUT, S2_HREADYOUT, S3_HREADYOUT, S4_HREADYOUT, S5_HREADYOUT;

//------------------------ 

    // assign HRESETn = 1'b1;
    assign LED_out = GPIO_OUT_A[2:0];
    assign ws = GPIO_OUT_A[3];

//------------------------ 

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


    ahbl_gpio GPIO (
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .HADDR(HADDR),
        .HTRANS(HTRANS),
        .HSIZE(HSIZE),
        .HWRITE(HWRITE),
        .HREADY(HREADY),
        .HSEL(S2_HSEL),
        .HWDATA(HWDATA),
        .HREADYOUT(S2_HREADYOUT),
        .HRDATA(S2_HRDATA),

        .GPIO_IN(GPIO_IN),
        .GPIO_OUT(GPIO_OUT),
        .GPIO_OE(GPIO_OE)
    );


    ahbl_ram #(.SIZE(8*1024)) PMEM (
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .HADDR(HADDR),
        .HTRANS(HTRANS),
        .HSIZE(HSIZE),
        .HWRITE(HWRITE),
        .HREADY(HREADY),
        .HSEL(S0_HSEL),
        .HWDATA(HWDATA),
        .HREADYOUT(S0_HREADYOUT),
        .HRDATA(S0_HRDATA),
        .read_uart(read_uart)
    );

    ahbl_ram #(.SIZE(8*740)) DMEM (
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
        .HRDATA(S1_HRDATA),
        .read_uart(read_uart)
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

    ahbl_i2s_rx MEMS(
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .HADDR(HADDR),
        .HTRANS(HTRANS),
        .HSIZE(HSIZE),
        .HWRITE(HWRITE),
        .HREADY(HREADY),
        .HSEL(i2s_SEL),
        .HWDATA(HWDATA),
        .HREADYOUT(i2s_HREADYOUT),
        .HRDATA(i2s_HRDATA),
        .rx(GPIO_OUT_A[0]),
        .ws(GPIO_OUT_A[3]),      
        .i2s_clk(i2s_clk), 
        .rx_data(I2S_out)
        
    );


    ahbl_timer timer (
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .HADDR(HADDR),
        .HTRANS(HTRANS),
        .HSIZE(HSIZE),
        .HWRITE(HWRITE),
        .HREADY(HREADY),
        .HSEL(timer_SEL),
        .HWDATA(HWDATA),
        .HREADYOUT(timer_HREADYOUT),
        .HRDATA(timer_HRDATA),

        .TIMER_OUT(TIMER_OUT)
    );

    // AHB-to-APB Bridge Instantiation
    apb2ahbl APB_BRIDGE (
        .HCLK(HCLK),
        .HRESETn(HRESETn),
        .HSEL(S4_HSEL),              // Selected by the AHB Splitter
        .HADDR(HADDR),
        .HTRANS(HTRANS),
        .HWRITE(HWRITE),
        .HREADY(HREADY),
        .HWDATA(HWDATA),
        .HSIZE(HSIZE),
        .HREADYOUT(S4_HREADYOUT),
        .HRDATA(S4_HRDATA),
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PRDATA(PRDATA),
        .PREADY(PREADY),
        .PWDATA(PWDATA),
        .PADDR(PADDR),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE)
    );

        // APB Module Instance
    apb APB_MODULE (
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PWRITE(PWRITE),
        .PWDATA(PWDATA),
        .PADDR(PADDR),
        .PENABLE(PENABLE),
        .PREADY(PREADY),
        .PRDATA(PRDATA),
        .GPIO_IN(GPIO_IN_D),
        .GPIO_OUT(GPIO_OUT_D),
        .GPIO_OE(GPIO_OE_D)
    );
    // Slave 3 does not exist
    //assign S3_HREADYOUT = 1'b1;
    //assign S3_HRDATA = 32'hBADDBEEF;


    ahbl_splitter #(
        .S0(4'h0),     // Program Memory
        .S1(4'h2),     // Data Memory
        .S2(4'h4),     // GPIO Port
        .S3(4'h5),     // UART Transmitter
        .S4(4'h6)      // APB Bridge
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
        .S3_HREADYOUT(S3_HREADYOUT),
        .S4_HSEL(S4_HSEL),
        .S4_HRDATA(S4_HRDATA),
        .S4_HREADYOUT(S4_HREADYOUT)
    );

    ahbl_gpio_splitter #(.A(3'h0), 
                        .B(3'h1),
                        .C(3'h2),
                        .timer(3'h3),
                        .i2s(3'h4)
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
        .C_HREADYOUT(1'b1),

        .timer_SEL(timer_SEL),
        .timer_HRDATA(timer_HRDATA),
        .timer_HREADYOUT(timer_HREADYOUT),

        .i2s_SEL(i2s_SEL),
        .i2s_HRDATA(i2s_HRDATA),
        .i2s_HREADYOUT(i2s_HREADYOUT)
    );
endmodule