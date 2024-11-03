module top (
    input wire          HCLK,
    input wire          HRESETn,
    input wire    I2S_input, // Assuming you are getting these 2 bits as input
    output wire UART_TX,
    output wire [1:0]  I2S_out, // Ensure this is an output
    output wire ws,
    output wire i2s_clk
    //output wire [2:0] LED_RGB  // LED outputs
);
    wire clk;
    wire [2:0] LED_data;

    // Fixed value for MODE_SEL
    localparam MODE_SEL = 1'b0; // Set to a fixed value for now
    // assign I2S_out = {I2S_input, 62'b0}; // Concatenates the 2 bits followed by 62 zeros

    // High-Frequency Oscillator configuration
    SB_HFOSC #(
        .CLKHF_DIV("0b11")  
    ) u_SB_HFOSC (
        .CLKHFPU(1'b1),
        .CLKHFEN(1'b1),
        .CLKHF(clk)
    );

    // Hazard2 SoC instantiation
    Hazard2_SoC SoC(
        .HCLK(clk),
        .HRESETn(1'b1),
        .I2S_input(I2S_input),
        .UART_TX(UART_TX),
        .I2S_out(I2S_out), // Correctly connect the output to the SoC
        .ws(ws),
        .i2s_clk(i2s_clk)
       ///.LED_out(LED_data)  // Assign LED data to the SoC's LED output
    );

    // RGB LED Driver configuration
    // SB_RGBA_DRV #(
    //     .CURRENT_MODE("0b1"),
    //     .RGB0_CURRENT("0b000111"),
    //     .RGB1_CURRENT("0b000111"),
    //     .RGB2_CURRENT("0b000111")
    // ) rgb_drv_I (
    //     .RGBLEDEN(1'b1),
    //     .RGB0PWM(LED_data[0]),  // Green
    //     .RGB1PWM(LED_data[1]),  // Red
    //     .RGB2PWM(LED_data[2]),  // Blue (unused in this case)
    //     .CURREN(1'b1),
    //     .RGB0(LED_RGB[0]),
    //     .RGB1(LED_RGB[1]),
    //     .RGB2(LED_RGB[2])
    // );

endmodule
