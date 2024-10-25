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


<<<<<<< HEAD
    // FInish when yoiu see a special pattern on the GPIO
    always@*
        if (I2S_out == 63'h00CDCDCDB00ABABAB) begin
            #1000;
            $display("TB: Test Passed");
=======
        // Example I2S data stream for two 32-bit stereo samples
        send_i2s_data(64'h55667788ABCDEFAB); 
        #10
        send_i2s_data(64'h22334455FBABABAB);
        #10
        send_i2s_data(64'hBABABABA55667788);
        #10
        send_i2s_data(64'h55667788ABCDEFAB);
        #100;

        #SIMTIME;
        $display("TB: Test Failed: Timeout");
        $finish;
    end

    // Task to send I2S data
    task send_i2s_data(input [63:0] data);
        integer i;
        begin
            for (i = 0; i < 64; i = i + 1) begin
                @(posedge i2s_clk);
                if(ws==1 && i>0 && i<32) 
                rx = data[i];
                else if(ws==0 && i>32 && i<64) 
                rx = data[i];  
            end
        end
    endtask

    // Monitor to check the received data and stop the simulation on a specific condition
    always @ (posedge i2s_clk) begin
        if (rx_data == 64'h0066778800CDEFAB) begin
            $display("TB: Test Passed: Received correct data");
            $finish;
        end
        if (rx_data == 64'h0033445500ABABAB) begin
            $display("TB: Test Passed: Received correct data");
            $finish;
        end
        if (rx_data == 64'h00BABABA00667788) begin
            $display("TB: Test Passed: Received correct data");
            $finish;
        end
        if (rx_data == 64'h0066778800CDEFAB) begin
            $display("TB: Test Passed: Received correct data");
>>>>>>> 09b6acf6a8fce3a5c0b6c075841ba13c7fcfe9f2
            $finish;
        end

endmodule