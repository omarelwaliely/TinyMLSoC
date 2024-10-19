/*
 * blink.v
 *
 * CC0 1.0 Universal - See LICENSE in this directory
 *
 * Copyright (C) 2018  Sylvain Munaut
 *
 * vim: ts=4 sw=4
 */

`default_nettype none

module light_control (
	input clk,
	input [2:0] RGB_in,
	output wire [2:0] LED_RGB
);


	// SB_RGBA_DRV #(
	// 	.CURRENT_MODE("0b1"),
	// 	.RGB0_CURRENT("0b000111"),
	// 	.RGB1_CURRENT("0b000111"),
	// 	.RGB2_CURRENT("0b000111")
	// ) rgb_drv_I (
	// 	.RGBLEDEN(1'b1),
	// 	.RGB0PWM(RGB_in[0]),
	// 	.RGB1PWM(RGB_in[1]),
	// 	.RGB2PWM(RGB_in[2]),
	// 	.CURREN(1'b1),
	// 	.RGB0(LED_RGB[0]),
	// 	.RGB1(LED_RGB[1]),
	// 	.RGB2(LED_RGB[2])
	// );

endmodule // blink

