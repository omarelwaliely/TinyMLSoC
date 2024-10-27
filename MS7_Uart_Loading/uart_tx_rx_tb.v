module uart_tx_rx_tb;
    reg          clk = 0;
    reg          rst_n = 0;
    reg          en;
    reg          start;
    reg  [7:0]   data;
    reg  [15:0]  baud_div;
    wire         tx;         
    wire         done_tx;   

    uart_tx UTX (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .start(start),
        .data(data),
        .baud_div(baud_div),
        .tx(tx),
        .done(done_tx)
    );


    wire [7:0] received_data; 
    wire done_rx;         

    uart_rx URX (
        .clk(clk),
        .rst_n(rst_n),
        .rx(tx),            
        .baud_div(baud_div),
        .data(received_data),
        .done(done_rx)
    );

    always #10 clk = !clk; 

    initial begin
        #777;
        @(posedge clk);
        #1 rst_n = 1;
    end

    initial begin
        $dumpfile("uart_tx_rx_tb.vcd");
        $dumpvars;
    end

    initial begin
        en = 0;
        start = 0;
        wait(rst_n == 1'b1);
        @(posedge clk);
        en = 1;
        baud_div = 9;

        // Transmit characters
        putchar(8'hA5);
        putchar(8'hF0);
        
        #100;
        $finish;
    end
  
    task putchar;
        input [7:0] char;
        begin
            @(posedge clk);
            data = char; 
            @(posedge clk);
            start = 1; 
            @(posedge clk);
            start = 0;
            wait(done_tx == 1'b1); 
            wait(done_rx == 1'b1); 
            if (received_data == char) begin
                $display("Received data: 0x%X", received_data);
            end else begin
                $display("Error: Expected 0x%X, but received 0x%X", char, received_data);
            end
        end
    endtask

endmodule
