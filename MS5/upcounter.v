module upcounter(
    input wire [31:0] load,
    input wire clk,
    input wire rst_n,
    input wire start,
    output reg [31:0] count
);
    reg execute;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= 32'h0; 
            execute <= 0;
        end
        else if (start) begin
            execute <= 1;
        end
        else if (execute) begin
            if (count == load) begin
                execute <= 0;
                count <= 0;
            end
            else begin
                count <= count + 1;
            end
        end
    end
endmodule
