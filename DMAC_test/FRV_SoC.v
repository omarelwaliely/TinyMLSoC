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

module FRV_SoC (
    input wire          HCLK,
    input wire          HRESETn,
    input wire I2S_in,
    output wire         UART_TX,
    output wire [2:0]   LED_out,
    output wire         ws,
    output wire         i2s_clk,
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

    //wire UART_TX;
    // wire [2:0] LED_out;
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

    wire IRQ;

    //GPIO SLAVE WIRES
    wire [31:0] A_HRDATA, B_HRDATA, C_HRDATA, timer_HRDATA, i2s_HRDATA;
    wire        A_SEL, B_SEL, C_SEL, timer_SEL, i2s_SEL;
    wire        A_HREADYOUT, B_HREADYOUT, C_HREADYOUT, timer_HREADYOUT, i2s_HREADYOUT;
    

//------------------------


    //SPLITTER SLAVE WIRES
    wire [31:0] S0_HRDATA, S1_HRDATA, S2_HRDATA, S3_HRDATA, S4_HRDATA, S5_HRDATA;
    wire        S0_HSEL, S1_HSEL, S2_HSEL, S3_HSEL, S4_HSEL, S5_HSEL;
    wire        S0_HREADYOUT, S1_HREADYOUT, S2_HREADYOUT, S3_HREADYOUT, S4_HREADYOUT, S5_HREADYOUT;



 //-----------Crossbar time
 
    localparam  N_MASTERS= 2;
    localparam N_SLAVES = 5;
    localparam W_ADDR = 32;
    localparam W_DATA = 32;
    parameter ADDR_MAP = 160'h00000000_20000000_40000000_80000000_60000000;
    parameter ADDR_MASK = 160'hF0000000_F0000000_F0000000_F0000000_F0000000;



    //making master lock only cpu for now until I make sure it works
    
    wire [31:0] HADDR_CPU;
    wire HWRITE_CPU;
    wire [1:0] HTRANS_CPU;
    wire [2:0] HSIZE_CPU;
    wire [2:0] HBURST_CPU = 3'd0; //always single
    wire HMASTLOCK_CPU = 1'b1; //always make the cpu the master for now
    wire [31:0] HWDATA_CPU;
    wire [3:0] HPROT_CPU = 4'd0; //we dont support prot



 


    //trying dummy values to see if stopping cpu and taking control is possible
    wire[31:0] HADDR_DMAC = 32'h20001000;
    wire HWRITE_DMAC = 1'b1;
    wire [1:0] HTRANS_DMAC = 2'b00; //to try transmitting i made this 10
    wire [2:0] HSIZE_DMAC = 3'd0;
    wire [2:0] HBURST_DMAC = 3'd0;
    wire HMASTLOCK_DMAC = 1'b1;
    wire [31:0] HWDATA_DMAC = 32'd100;
    wire [3:0] HPROT_DMAC = 4'd0; //we dont support prot
    wire stop = 1'b0; //set this to 1 to take control





    //--concatenated vectors

    //master
    wire [N_MASTERS-1:0] src_hready_resp; 
    wire [N_MASTERS-1:0] src_hresp; //we definitly dont use this in our design but ill keep it here jic
    wire [N_MASTERS*W_ADDR-1:0] src_haddr = {HADDR_DMAC, HADDR_CPU};
    wire [N_MASTERS-1:0] src_hwrite = {HWRITE_DMAC,HWRITE_CPU};
    wire [N_MASTERS*2-1:0] src_htrans = {HTRANS_DMAC,HTRANS_CPU};
    wire [N_MASTERS*3-1:0] src_hsize = {HSIZE_DMAC,HSIZE_CPU};
    wire [N_MASTERS*3-1:0] src_hburst = {HBURST_DMAC,HBURST_CPU};
	wire [N_MASTERS*4-1:0]      src_hprot = {HPROT_DMAC,HPROT_CPU};
    wire [N_MASTERS-1:0] src_hmastlock = {HMASTLOCK_DMAC,HMASTLOCK_CPU};
    wire [N_MASTERS*W_DATA-1:0] src_hwdata = {HWDATA_DMAC,HWDATA_CPU};
    wire [N_MASTERS*W_DATA-1:0] src_hrdata;

    //assigning output master wires

    wire [W_DATA-1:0] CPU_HRDATA = src_hrdata[W_DATA*0+:W_DATA];
    wire [W_DATA-1:0] DMAC_HRDATA = src_hrdata[W_DATA*1:W_DATA];

    wire CPU_HREADY = src_hready_resp[0];
    wire DMAC_HREADY = src_hready_resp[1];


    //slaves
    wire [N_SLAVES-1:0] dst_hready;
    wire [N_SLAVES-1:0]         dst_hready_resp ={S0_HREADYOUT,S1_HREADYOUT,S2_HREADYOUT,S3_HREADYOUT,S4_HREADYOUT};
    wire [N_SLAVES-1:0]         dst_hresp = 5'd1; // we dont use this wire in our design so ill set it to 1's indicating no failure
    wire [N_SLAVES*W_ADDR-1:0]  dst_haddr;
    wire [N_SLAVES-1:0]         dst_hwrite;
    wire [N_SLAVES*2-1:0]       dst_htrans;
    wire [N_SLAVES*3-1:0]       dst_hsize;
    wire [N_SLAVES*3-1:0]       dst_hburst;
    wire [N_SLAVES*4-1:0]       dst_hprot;
    wire [N_SLAVES-1:0]         dst_hmastlock; //we dont have any advanced slaves so this isnt really needed (ex: MPMC)
    wire [N_SLAVES*W_DATA-1:0]  dst_hwdata;
    wire [N_SLAVES*W_DATA-1:0]  dst_hrdata = {S0_HRDATA, S1_HRDATA, S2_HRDATA, S3_HRDATA,S4_HRDATA}; //they all take the same HRDATA (HRDATA) in our design


    //all slaves can receive the these same values without causing conflicts so ill recycle for now
    assign HREADY = dst_hready[0];
    assign HADDR  = dst_haddr[0*W_ADDR+:W_ADDR];
    assign HWRITE  = dst_hwrite[0];
    assign HSIZE = dst_hsize[0*3+:3];
    assign HWDATA = dst_hwdata[0];


    wire ROM_hready = dst_hready[4];  
    wire RAM_hready = dst_hready[3];
    wire GPIO_SPLITTER_hready = dst_hready[2]; 
    wire UART_hready = dst_hready[1];
    wire APB_hready = dst_hready[0];

    wire[W_ADDR-1:0] ROM_haddr = dst_haddr[4*W_ADDR+:W_ADDR];
    wire[W_ADDR-1:0] RAM_haddr = dst_haddr[3*W_ADDR+:W_ADDR];
    wire[W_ADDR-1:0] GPIO_SPLITTER_haddr = dst_haddr[2*W_ADDR+:W_ADDR];
    wire[W_ADDR-1:0] UART_haddr = dst_haddr[1*W_ADDR+:W_ADDR];
    wire[W_ADDR-1:0] APB_haddr = dst_haddr[0*W_ADDR+:W_ADDR];

    wire ROM_hwrite = dst_hwrite[4];
    wire RAM_hwrite = dst_hwrite[3];
    wire GPIO_SPLITTER_hwrite = dst_hwrite[2];
    wire UART_hwrite = dst_hwrite[1];
    wire APB_hwrite = dst_hwrite[0];

    wire[2:0] ROM_hsize = dst_hsize[4*3+:3];
    wire[2:0] RAM_hsize = dst_hsize[3*3+:3];
    wire[2:0] GPIO_SPLITTER_hsize = dst_hsize[2*3+:3];
    wire[2:0] UART_hsize = dst_hsize[1*3+:3];
    wire[2:0] APB_hsize = dst_hsize[0*3+:3];

    wire[W_DATA-1:0] ROM_hwdata = dst_hwdata[4*W_DATA+:W_DATA];
    wire[W_DATA-1:0] RAM_hwdata = dst_hwdata[3*W_DATA+:W_DATA];
    wire[W_DATA-1:0] GPIO_SPLITTER_hwdata = dst_hwdata[2*W_DATA+:W_DATA];
    wire[W_DATA-1:0] UART_hwdata = dst_hwdata[1*W_DATA+:W_DATA];
    wire[W_DATA-1:0] APB_hwdata = dst_hwdata[0*W_DATA+:W_DATA]; 

    wire [1:0] ROM_htrans = dst_htrans[8+:2];
    wire [1:0] RAM_htrans = dst_htrans[6+:2];
    wire [1:0] GPIO_SPLITTER_htrans = dst_htrans[4+:2];
    wire [1:0] UART_htrans = dst_htrans[2+:2];
    wire [1:0] APB_htrans = dst_htrans[0+:2];







    ahbl_crossbar #(
        .N_MASTERS(N_MASTERS),
        .N_SLAVES(N_SLAVES),
        .W_ADDR(W_ADDR),
        .W_DATA(W_DATA),
        .ADDR_MAP(ADDR_MAP),
        .ADDR_MASK(ADDR_MASK)
        ) CROSSBAR (
        .clk(HCLK),
        .rst_n(HRESETn),
        .src_hready_resp(src_hready_resp), 
        .src_hresp(src_hresp),
        .src_haddr(src_haddr),
        .src_hwrite(src_hwrite),
        .src_htrans(src_htrans),
        .src_hsize(src_hsize),
        .src_hburst(src_hburst),
        .src_hprot(src_hprot),
        .src_hmastlock(src_hmastlock),
        .src_hwdata(src_hwdata),
        .src_hrdata(src_hrdata),// output

        .dst_hready(dst_hready),
        .dst_hready_resp(dst_hready_resp),
        .dst_hresp(dst_hresp),
        .dst_haddr(dst_haddr),
        .dst_hwrite(dst_hwrite),
        .dst_htrans(dst_htrans),
        .dst_hsize(dst_hsize),
        .dst_hburst(dst_hburst),
        .dst_hprot(dst_hprot),
        .dst_hmastlock(dst_hmastlock),
        .dst_hwdata(dst_hwdata),
        .dst_hrdata(dst_hrdata) //input
    );


    FRV_AHBL CPU (
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .HADDR(HADDR_CPU),
        .HTRANS(HTRANS_CPU),
        .HSIZE(HSIZE_CPU),
        .HWRITE(HWRITE_CPU),
        .HWDATA(HWDATA_CPU),
        .HREADY(CPU_HREADY),
        .HRDATA(CPU_HRDATA),
        .IRQ(IRQ),

        .stop(stop)
    );

    ahbl_gpio GPIO_A (
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .HADDR(GPIO_SPLITTER_haddr),
        .HTRANS(GPIO_SPLITTER_htrans),
        .HSIZE(GPIO_SPLITTER_hsize),
        .HWRITE(GPIO_SPLITTER_hwrite),
        .HREADY(GPIO_SPLITTER_hready),
        .HSEL(A_SEL),
        .HWDATA(GPIO_SPLITTER_hwdata),
        .HREADYOUT(A_HREADYOUT),
        .HRDATA(A_HRDATA),

        .GPIO_IN(GPIO_IN_A),
        .GPIO_OUT(GPIO_OUT_A),
        .GPIO_OE(GPIO_OE_A)
    );


    ahbl_ram #(.SIZE(8*1024)) PMEM (
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .HADDR(ROM_haddr),
        .HTRANS(ROM_htrans),
        .HSIZE(ROM_hsize),
        .HWRITE(ROM_hwrite),
        .HREADY(ROM_hready),
        .HWDATA(ROM_hwdata),
        .HREADYOUT(S0_HREADYOUT),
        .HRDATA(S0_HRDATA)
    );

    ahbl_ram #(.SIZE(8*740)) DMEM (
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .HADDR(RAM_haddr),
        .HTRANS(RAM_htrans),
        .HSIZE(RAM_hsize),
        .HWRITE(RAM_hwrite),
        .HREADY(RAM_hready),
        .HWDATA(RAM_hwdata),
        .HREADYOUT(S1_HREADYOUT),
        .HRDATA(S1_HRDATA)
    );

    ahbl_uart_tx TX (
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .HADDR(UART_haddr),
        .HTRANS(UART_htrans),
        .HSIZE(UART_hsize),
        .HWRITE(UART_hwrite),
        .HREADY(UART_hready),
        .HWDATA(UART_hwdata),
        .HREADYOUT(S3_HREADYOUT),
        .HRDATA(S3_HRDATA),

        .tx(UART_TX)
    );


    ahbl_i2s MIC(
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .HADDR(GPIO_SPLITTER_haddr),
        .HTRANS(GPIO_SPLITTER_htrans),
        .HSIZE(GPIO_SPLITTER_hsize),
        .HWRITE(GPIO_SPLITTER_hwrite),
        .HREADY(GPIO_SPLITTER_hready),
        .HSEL(i2s_SEL),
        .HWDATA(GPIO_SPLITTER_hwdata),
        .HREADYOUT(i2s_HREADYOUT),
        .HRDATA(i2s_HRDATA),
        .SD(I2S_in),      
        .SCK(i2s_clk),
        .WS(ws),
        .IRQ(IRQ)

);


    ahbl_timer timer (
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .HADDR(GPIO_SPLITTER_haddr),
        .HTRANS(GPIO_SPLITTER_htrans),
        .HSIZE(GPIO_SPLITTER_hsize),
        .HWRITE(GPIO_SPLITTER_hwrite),
        .HREADY(GPIO_SPLITTER_hready),
        .HSEL(timer_SEL),
        .HWDATA(GPIO_SPLITTER_hwdata),
        .HREADYOUT(timer_HREADYOUT),
        .HRDATA(timer_HRDATA),

        .TIMER_OUT(TIMER_OUT)
    );

    // AHB-to-APB Bridge Instantiation
    apb2ahbl APB_BRIDGE (
        .HCLK(HCLK),
        .HRESETn(HRESETn),
        .HADDR(APB_haddr),
        .HTRANS(APB_htrans),
        .HWRITE(APB_hwrite),
        .HREADY(APB_hready),
        .HWDATA(APB_hwdata),
        .HSIZE(APB_hsize),
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


    // ahbl_splitter #(
    //     .S0(4'h0),     // Program Memory
    //     .S1(4'h2),     // Data Memory
    //     .S2(4'h4),     // GPIO Port
    //     .S3(4'h8),     // UART Transmitter
    //     .S4(4'h6)      // APB Bridge
    // ) SPLITTER (
    //     .HCLK(HCLK),
    //     .HRESETn(HRESETn),
    //     .HADDR(HADDR),
    //     .HTRANS(HTRANS),
    //     .HREADY(HREADY),
    //     .HRDATA(HRDATA),
    //     .S0_HSEL(S0_HSEL),
    //     .S0_HRDATA(S0_HRDATA),
    //     .S0_HREADYOUT(S0_HREADYOUT),
    //     .S1_HSEL(S1_HSEL),
    //     .S1_HRDATA(S1_HRDATA),
    //     .S1_HREADYOUT(S1_HREADYOUT),
    //     .S2_HSEL(S2_HSEL),
    //     .S2_HRDATA(S2_HRDATA),
    //     .S2_HREADYOUT(S2_HREADYOUT),
    //     .S3_HSEL(S3_HSEL),
    //     .S3_HRDATA(S3_HRDATA),
    //     .S3_HREADYOUT(S3_HREADYOUT),
    //     .S4_HSEL(S4_HSEL),
    //     .S4_HRDATA(S4_HRDATA),
    //     .S4_HREADYOUT(S4_HREADYOUT)
    // );

    ahbl_gpio_splitter #(.A(4'h0), 
                        .B(4'h1),
                        .C(4'h2),
                        .timer(4'h3),
                        .i2s(4'h4)
    ) GPIO_SPLITTER (
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .HADDR(GPIO_SPLITTER_haddr),
        .HTRANS(GPIO_SPLITTER_htrans),
        .HREADY(GPIO_SPLITTER_hready),
        .HRDATA(S2_HRDATA),
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