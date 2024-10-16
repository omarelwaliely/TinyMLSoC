module top (
    output wire TX
);
    wire clk;


    SB_HFOSC #(
    .CLKHF_DIV("0b11")  
    ) u_SB_HFOSC (
        .CLKHFPU(1'b1),
        .CLKHFEN(1'b1),
        .CLKHF(clk)
    );


    Hazard2_SoC SoC(
    .HCLK(clk),
    .UART_TX(TX)
    );


endmodule