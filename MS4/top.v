module top (
    output wire [2:0] LED_RGB
);
    wire clk;
    wire [2:0] LED_data;


    SB_HFOSC #(
    .CLKHF_DIV("0b11")  
    ) u_SB_HFOSC (
        .CLKHFPU(1'b1),
        .CLKHFEN(1'b1),
        .CLKHF(clk)
    );


    Hazard2_SoC SoC(
    .HCLK(clk),
    .HRESETn(1'b1),
    .LED_out(LED_data)
    );


	SB_RGBA_DRV #(
		.CURRENT_MODE("0b1"),
		.RGB0_CURRENT("0b000111"),
		.RGB1_CURRENT("0b000111"),
		.RGB2_CURRENT("0b000111")
	) rgb_drv_I (
		.RGBLEDEN(1'b1),
		.RGB0PWM(LED_data[0]),
		.RGB1PWM(LED_data[1]),
		.RGB2PWM(LED_data[2]),
		.CURREN(1'b1),
		.RGB0(LED_RGB[0]),
		.RGB1(LED_RGB[1]),
		.RGB2(LED_RGB[2])
	);
endmodule