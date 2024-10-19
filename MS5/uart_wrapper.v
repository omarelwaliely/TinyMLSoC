module uart_wrapper (
    input wire          clk,
    input wire          rst_n,
    input wire          en,
    input wire          start_tx,
    input wire  [7:0]   data_tx,
    input wire          rx,
    input wire  [15:0]  baud_div,
    output wire         tx,
    output wire [7:0]   data_rx,
    output wire         done_tx,
    output wire         done_rx
);
    // Instantiate the UART TX
    uart_tx tx_module (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .start(start_tx),
        .data(data_tx),
        .baud_div(baud_div),
        .tx(tx),
        .done(done_tx)
    );

    // Instantiate the UART RX
    uart_rx rx_module (
        .clk(clk),
        .rst_n(rst_n),
        .rx(rx),
        .baud_div(baud_div),
        .data(data_rx),
        .done(done_rx)
    );

endmodule
