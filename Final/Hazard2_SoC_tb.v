`timescale 1ns / 1ps

module Hazard2_SoC_tb;

    // Testbench signals
    reg         HCLK;
    reg         HRESETn;
    reg en;
    wire         I2S_in;     
    wire        UART_TX;
    wire [2:0]  LED_out;
    wire        ws;
    wire        i2s_clk;
    wire [31:0] HADDR;
    wire [2:0]  HSIZE;
    wire [1:0]  HTRANS;
    wire        HWRITE;
    wire [31:0] HWDATA;
    wire        HREADY;
    wire [31:0] HRDATA;

    // Clock generation
    initial begin
        HCLK = 0;
    forever #3 HCLK = ~HCLK; // 6 MHz clock 
    end


    i2s_test tb (
        .WS(ws),
        .BCLK(i2s_clk),
        .DIN(I2S_in),
        .en(en),
        .rst_n(HRESETn)
    );
        Hazard2_SoC uut (
        .HCLK(HCLK),
        .HRESETn(HRESETn),
        .I2S_in(I2S_in),
        .UART_TX(UART_TX),
        .LED_out(LED_out),
        .ws(ws),
        .i2s_clk(i2s_clk),
        .HADDR(HADDR),
        .HSIZE(HSIZE),
        .HTRANS(HTRANS),
        .HWRITE(HWRITE),
        .HWDATA(HWDATA),
        .HREADY(HREADY),
        .HRDATA(HRDATA)
    );

     serial_terminal terminal (
        .clk(HCLK),             
        .rst_n(HRESETn),           
        .rx(UART_TX),           
        .baud_div(3)  
    );
    
    initial begin
        HRESETn = 0;
        #47;
        @(posedge HCLK);
        HRESETn = 1;
    end
    // Dump waveforms to a file
    initial begin
        $dumpfile("hazard2_soc_tb.vcd");
        
        $dumpvars(0, Hazard2_SoC_tb);  
        wait(HRESETn == 1'b1);   
        @(posedge HCLK);         
        en = 1;    
        #80000;  // Run simulation for 1000ns (1us) before stopping
        $finish; // End the simulation
    end

endmodule
