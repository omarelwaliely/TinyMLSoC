module uart_rx (
    input wire          clk,
    input wire          rst_n,
    input wire          rx,
    input wire  [15:0]  baud_div,
    output reg [7:0]    data,
    output reg         done
);

    reg         run;
    reg [15:0]  baud_cntr;
    reg [9:0]   rx_reg;
    reg [3:0]   bit_cntr;
    reg         last;

    wire tick = (baud_cntr == 16'b0);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            baud_cntr <= 16'hFFFF; 
        end else if (tick) begin
            baud_cntr <= baud_div;
        end else if (run) begin
            baud_cntr <= baud_cntr - 1'b1; 
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            run <= 1'b0;
            bit_cntr <= 4'b0;
            rx_reg <= 10'b1111111111; 
            done <= 1'b0;
            data <= 8'b0;
            last <= 1'b0;
        end else begin
            if (run) begin
                if (tick) begin
                    if (last) begin
                        data <= rx_reg[8:1]; 
                        done <= 1'b1; 
                        run <= 1'b0; 
                        last <= 1'b0;
                    end
                    else if (bit_cntr > 0) begin
                        rx_reg <= {rx, rx_reg[9:1]};
                        bit_cntr <= bit_cntr - 1'b1;
                        if (bit_cntr == 4'd1) begin
                            last <= 1'b1;
                        end
                    end
                    else if (bit_cntr == 4'd0) begin
                        if (~rx) begin
                            run <= 1'b1;  
                            bit_cntr <= 4'd9;
                        end
                    end
                end
            end else if (bit_cntr == 4'd0 && ~rx) begin
                run <= 1'b1; 
                baud_cntr <= baud_div;
            end else begin
                done <= 1'b0;
            end
        end
    end

endmodule
