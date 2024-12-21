module i2s(
    input clk,
    input rst_n,
    output WS,
    output BCLK,
    input DIN,
    output reg done,
    output [size - 1:0] data,
    input en,
    output reg vad_active // Indicates voice activity
);

localparam size = 32;
localparam window_size = 80; // Window size for accumulation
localparam slide_size = 40;  // Sliding window size
localparam vad_threshold = 1000; // Threshold for voice activity detection (adjust as needed)

reg BCLK_d, WS_d;
reg [size - 1:0] shift_reg;
reg [6:0] WS_cntr;
reg [1:0] BCLK_cntr;
reg [1:0] done_cntr;
reg [75:0] accumulator; // 16-bit accumulator for VAD (modify based on precision requirements)
reg [6:0] sample_count; // Tracks the number of samples in the current window
reg sliding;            // Indicates if the sliding window logic is active

// Wires
wire done_cntr_zero = done_cntr == 2'b00;
wire WS_cntr_zero = WS_cntr == 7'b1000000;
wire cntr_two = BCLK_cntr == 2'b10;

// WS logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        WS_d <= 0;
    end
    else if (en) begin
        if (WS_cntr_zero && BCLK_cntr == 0) begin
            WS_d <= !WS_d;
        end
    end
end

// WS counter
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        WS_cntr <= 0;
    end
    else if (en) begin
        if (cntr_two) begin
            WS_cntr <= WS_cntr + 1;
        end
    end
end

// BCLK logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        BCLK_d <= 0;
    end
    else if (en) begin
        if (cntr_two) begin
            BCLK_d <= ~BCLK_d;
        end
    end
end

// BCLK counter
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        BCLK_cntr <= 0;
    end
    else if (en) begin
        if (cntr_two) begin
            BCLK_cntr <= 0;
        end
        else BCLK_cntr <= BCLK_cntr + 1;
    end
end

// Shift register
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        shift_reg <= 32'd0;
    end
    else if (en) begin
        if (BCLK_cntr == 0 && !BCLK) begin 
            shift_reg <= {shift_reg[size - 2 : 0], DIN};
        end
    end
end

// Done signal
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        done <= 0;
    end
    else if (en) begin
        if (WS_cntr_zero && cntr_two) begin
            done <= 1;
        end
        else done <= 0;
    end
end

// VAD Logic: Accumulator and Sliding Window
wire [37:0]left_accum = abs(accumulator[76 - 1:38]);
wire [37:0]right_accum = abs(accumulator[38 -1:0]);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        accumulator <= 0;
        sample_count <= 0;
        sliding <= 0;
        vad_active <= 0;
    end
    else if (en  && done) begin
        if (1) begin
            accumulator[38 -1:0] <= accumulator[38 -1:0] + abs(shift_reg[size - 1:0]); // Add current sample to accumulator
            sample_count <= sample_count + 1;

            // Check if window is full 80
            // if (sample_count == window_size) begin
            //     sliding <= 1; // Start sliding window
            //     vad_active <= (accumulator > vad_threshold); // Check threshold
            // end

            if (sample_count == slide_size) begin
                vad_active <= ((abs(accumulator[76 - 1:38]) + abs(accumulator[38 -1:0])) > vad_threshold); // Check threshold
                //accumulator <= accumulator - abs(accumulator[48 - 1:24]); // Remove oldest sample
                accumulator <= {accumulator[38 -1:0], 38'd0};  // shift 40 lsb of accumulator to the left
                sample_count <= 0; // Reset sample count for sliding window
            end
                
            // Sliding logic
            // if (sliding && sample_count == slide_size) begin
            //     accumulator <= accumulator - abs(accumulator[size - 1:0]); // Remove oldest sample
            //     sample_count <= 0; // Reset sample count for sliding window
            //     // sample_count <= window_size - slide_size; // Reset sample count for sliding window
            // end
        end
    end
end

// Assign outputs
assign WS = WS_d;
assign BCLK = BCLK_d;
assign data = shift_reg;

// Absolute value function
function [size - 1:0] abs;
    input [size - 1:0] val;
    abs = (val[size - 1] == 1) ? (~val + 1) : val;
endfunction

endmodule