module i2s_wrapper (
    input wire reset,
    input wire clk,
    output wire [31:0] SAMPLE_REG,
    input wire [15:0] CONTROL_REG_in,
    output wire [15:0] CONTROL_REG_out
);

// Register Declarations
reg [31:0] SAMPLE_REG_reg;
reg [15:0] CONTROL_REG_reg;

// Register Logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        SAMPLE_REG_reg <= 32'b0;
        CONTROL_REG_reg <= 16'b0;
    end else begin
        CONTROL_REG_reg <= CONTROL_REG_in;
    end
end

// Output Assignments
assign SAMPLE_REG = SAMPLE_REG_reg;
assign CONTROL_REG_out = CONTROL_REG_reg;

endmodule