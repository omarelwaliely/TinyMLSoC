module i2s_rx (
    input wire clk,             // System clock
    input wire rst_n,           // Active-low reset
    input wire rx,              // I2S receive input
    output reg  ws,
    output reg i2s_clk,
    output reg [63:0] rx_data  // Received data
);

    //I2S Receiver States
    parameter STATE_IDLE  = 2'b00;
    parameter RIGHT_STEREO = 2'b01;
    parameter LEFT_STEREO  = 2'b10;


    reg [1:0] state;
    reg [5:0] bit_idx;
    reg [63:0] rx_shift_reg;
    reg clk_count; 

// Clock divider (4MHz)
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        clk_count <= 0;
        i2s_clk <= 0;
    end else begin
        if (clk_count == 1) begin
            i2s_clk <= ~i2s_clk; 
            clk_count <= 0;
        end else begin
            clk_count <= clk_count + 1;
        end
    end
end


    always @(posedge i2s_clk or negedge rst_n) begin
        if (!rst_n) begin
            state         <= STATE_IDLE;
            bit_idx       <= 6'b0;
            rx_shift_reg  <= 64'b0;
            rx_data       <= 32'b0;
            ws <= 1;


        end else begin
            case (state)
                RIGHT_STEREO: begin
                    ws = 1;
                    if (bit_idx >= 31) begin
                    bit_idx <= bit_idx + 1;
                    rx_data[31:0]       <= rx_shift_reg[31:0];
                    state <= LEFT_STEREO;
                    rx_shift_reg[31:0]  <= 32'd0;
                    end else begin
                            rx_shift_reg[bit_idx] <= rx;
                            bit_idx <= bit_idx + 1;
                            if(bit_idx>=24)
                            rx_shift_reg[bit_idx] <= 1'b0;
                    end
                
                end
                LEFT_STEREO: begin
                    ws <= 1'b0;
                    if (bit_idx >= 63) begin
                    rx_data[63:32]       <= rx_shift_reg[63:32];
                    state <= RIGHT_STEREO;
                    rx_shift_reg[63:32]  <= 32'd0;
                    bit_idx <= 6'b0;
                    end else begin
                            rx_shift_reg[bit_idx] <= rx;
                            bit_idx <= bit_idx + 1;
                            if(bit_idx>=56)
                            rx_shift_reg[bit_idx] <= 1'b0;
                    end
                end 
                STATE_IDLE: begin
                     state    <= RIGHT_STEREO;
                end
                default: state <= STATE_IDLE;
            endcase
        end
    end

endmodule