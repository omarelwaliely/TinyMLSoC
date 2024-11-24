module i2s #(
    parameter WSZ = 32
)(
    input wire clk,
    input wire rst_n,
    input wire [0:0] mode,
    input wire [0:0] tick,
    input wire [0:0] SD,
    output wire [WSZ-1:0] sample,
    output wire [0:0] rdy,
    output wire [0:0] SCK,
    output wire [0:0] WS
);

// Register Declarations
reg [WSZ-1:0] shifter_reg;
reg [5:0] cntr_reg;
reg [0:0] ws_reg;

// Register Logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        shifter_reg <= 0;
        cntr_reg <= 0;
        ws_reg <= 0;
    end else begin
        shifter_reg <= shifter;
        cntr_reg <= cntr;
        ws_reg <= ws;
    end
end

// Output Assignments

endmodule