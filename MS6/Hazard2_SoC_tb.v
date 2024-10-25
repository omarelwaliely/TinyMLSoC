module Hazard2_SoC_tb;

    localparam SIMTIME = 50_000;

    reg         HCLK;
    reg         HRESETn;

    wire [63:0] I2S_out;
    wire        ws;
    wire        i2s_clk;
    // wire [31:0] GPIO_OE;
    // wire [31:0] GPIO_IN;


    
    // clock
    initial HCLK = 0;
    always #5 HCLK = ~HCLK;

    // Reset
    initial begin
        HRESETn = 0;
        #47;
        @(posedge HCLK);
        HRESETn = 1;
    end

    // TB infrastructure
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
        .i2s_clk(i2s_clk)
    );

    // Simulate the GPIO
    // tri [31:0] PORT;
    // assign PORT = GPIO_OE ? GPIO_OUT : 32'hZZZZ_ZZZZ;
    // assign GPIO_IN = PORT;


    // FInish when yoiu see a special pattern on the GPIO
    always@*
        if (I2S_out == 63'h00CDCDCDB00ABABAB) begin
            #1000;
            $display("TB: Test Passed");
            $finish;
        end

endmodule