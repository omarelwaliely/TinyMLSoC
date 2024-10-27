module Hazard2_SoC_tb;

    localparam SIMTIME = 50_000;

    reg         HCLK;
    reg         HRESETn;
    reg read_uart;

    wire [63:0] I2S_out;
    wire        ws;
    wire        i2s_clk;
    


    
    initial HCLK = 0;
    always #5 HCLK = ~HCLK;

    // Reset
    initial begin
        HRESETn = 0;
        #47;
        @(posedge HCLK);
        HRESETn = 1;
        #10000;
        HRESETn =0;
        #1000;
        read_uart =1;
        #1000;
        read_uart =0;
        #1000;
        @(posedge HCLK);
        HRESETn = 1;
    end

    initial begin
        $dumpfile("Hazard2_SoC_tb.vcd");
        $dumpvars(0, Hazard2_SoC_tb);
        #SIMTIME;
        $display("TB: Test Failed: Timeout");
        $finish;
    end

    Hazard2_SoC MUV (
        .HCLK(HCLK),
        .HRESETn(HRESETn),
        .I2S_out(I2S_out),
        .ws(ws),
        .i2s_clk(i2s_clk),
        .read_uart(read_uart)
    );

endmodule