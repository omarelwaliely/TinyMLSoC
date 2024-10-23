module i2s_rx_tb;

    localparam SIMTIME = 100_000; // Simulation time

    reg clk;
    reg rst_n;
    reg rx;
    wire ws;
    wire i2s_clk;
    wire [63:0] rx_data;

    // clock
    initial clk = 0;
    always #5 clk = ~clk;

    // Reset
    initial begin
        rst_n = 0;
        #20; // Assert reset for a short period
        @(posedge clk);
        rst_n = 1;
    end

    // TB infrastructure
    initial begin
        $dumpfile("i2s_rx_tb.vcd");
        $dumpvars(0, i2s_rx_tb);
        #SIMTIME;
        $display("TB: Test Failed: Timeout");
        $finish;
    end

    // Instantiate the I2S Receiver
    i2s_rx uut (
        .clk(clk),
        .rst_n(rst_n),
        .rx(rx),
        .ws(ws),
        .i2s_clk(i2s_clk),
        .rx_data(rx_data)
    );

    // Test case: Generate I2S data stream
    initial begin
        // Initialize signals
        rx = 0;

        @(posedge rst_n);
        #50;

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
            $finish;
        end


    end

endmodule
