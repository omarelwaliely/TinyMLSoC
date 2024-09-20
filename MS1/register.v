module register #(parameter n = 32)(
    input clk, 
    input rst_n,
    input load,
    input [n-1:0] D, 
    output reg [n-1:0] Q
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            Q <= 0;
        end else if (load) begin
            Q <= D;
        end
        else Q <= Q
    end
endmodule