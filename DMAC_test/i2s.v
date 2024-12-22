module i2s #(parameter WSZ=32)(
    input   wire            clk,
    input   wire            rst_n,
    input   wire            mode,
    input   wire            tick,
    output  wire [WSZ-1:0]  sample,
    output  wire            rdy,

    input   wire            SD,
    output  wire            SCK,
    output  wire            WS,
    output  reg             vad_active // Indicates voice activity

);

    reg [WSZ-1:0]           shifter;
    reg [5:0]               cntr;

    always@(posedge clk, negedge rst_n)
        if(!rst_n)
            shifter <= 'b0;
        else if(tick & ~SCK)
            shifter <= {shifter[WSZ-2:0], SD};

    always@(posedge clk, negedge rst_n)
        if(!rst_n)
            cntr <= 'b0;
        else if(tick)
            cntr <= cntr + 1'b1;

    reg ws;
    always@(posedge clk, negedge rst_n)
        if(!rst_n)
            ws <= 'b0;
        else if(tick)
            if(cntr == 6'h3F)
                ws <= ~ws;

    localparam size = 32;
    localparam window_size = 80; // Window size for accumulation
    localparam slide_size = 40;  // Sliding window size
    localparam vad_threshold = 4220000000;   //4200000000

    reg [75:0] accumulator; // 16-bit accumulator for VAD (modify based on precision requirements)
    reg [6:0] sample_count;

    // VAD Logic: Accumulator and Sliding Window
    wire [37:0]left_accum = abs(accumulator[76 - 1:38]);
    wire [37:0]right_accum = abs(accumulator[38 -1:0]);
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            accumulator <= 0;
            sample_count <= 0;
            vad_active <= 0;
        end
        else if (rdy) begin
                accumulator[38 -1:0] <= accumulator[38 -1:0] + abs(shifter[WSZ - 1:0]); // Add current sample to accumulator
                sample_count <= sample_count + 1;
    
                if (sample_count == slide_size) begin
                    vad_active <= ((abs(accumulator[76 - 1:38]) + abs(accumulator[38 -1:0])) > vad_threshold); // Check threshold
                    //accumulator <= accumulator - abs(accumulator[48 - 1:24]); // Remove oldest sample
                    accumulator <= {accumulator[38 -1:0], 38'd0};  // shift 40 lsb of accumulator to the left
                    sample_count <= 0; // Reset sample count for sliding window
                end
        end
    end
    
    assign SCK = cntr[0];
    assign WS = ws;
    assign sample = shifter;
    assign rdy = tick & (cntr == (mode ? (6'h01) : (6'h3F)));


// Absolute value function
function [size - 1:0] abs;
    input [size - 1:0] val;
    abs = (val[size - 1] == 1) ? (~val + 1) : val;
endfunction

endmodule