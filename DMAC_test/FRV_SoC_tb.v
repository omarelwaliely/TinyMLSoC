`timescale 1ns / 1ps

module FRV_SoC_tb;

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
    forever #5 HCLK = ~HCLK;
    end


    i2s_test tb (
        .WS(ws),
        .BCLK(i2s_clk),
        .DIN(I2S_in),
        .en(en),
        .rst_n(HRESETn)
    );
        FRV_SoC uut (
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
        .baud_div(16'h3)  
    );
    
    initial begin
        HRESETn = 0;
        #47;
        @(posedge HCLK);
        HRESETn = 1;
    end
    // Dump waveforms to a file
    initial begin
        $dumpfile("FRV_SoC_tb.vcd");
        
        $dumpvars(0, FRV_SoC_tb);  
        wait(HRESETn == 1'b1);   
        @(posedge HCLK);         
        en = 1;    
        #100000; 
        $finish; // End the simulation
    end

endmodule