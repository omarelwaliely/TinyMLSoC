module Hazard2_SoC_tb;
    reg         HCLK;
    reg         HRESETn;

    wire [31:0] GPIO_OUT_A;
    wire [31:0] GPIO_OE_A;
    wire [31:0] GPIO_IN_A;

    wire [31:0] GPIO_OUT_B;
    wire [31:0] GPIO_OE_B;
    wire [31:0] GPIO_IN_B;

    
    wire [31:0] GPIO_OUT_C;
    wire [31:0] GPIO_OE_C;
    wire [31:0] GPIO_IN_C;
    
    // clock
    initial HCLK = 0;
    always #5 HCLK = ~HCLK;

    // Reset
    initial begin
        HRESETn = 0;
        #47;
        @(posedge HCLK);
        HRESETn = 1;
    end

    // TB infrastructure
    initial begin
        $dumpfile("Hazard2_SoC_tb.vcd");
        $dumpvars(0, Hazard2_SoC_tb);
        #100000;
        $display("Test Failed: Timeout");
        $finish;
    end

    Hazard2_SoC MUV (
        .HCLK(HCLK),
        .HRESETn(HRESETn),

        .GPIO_OUT_A(GPIO_OUT_A),
        .GPIO_OE_A(GPIO_OE_A),
        .GPIO_IN_A(GPIO_IN_A),

        .GPIO_OUT_B(GPIO_OUT_B),
        .GPIO_OE_B(GPIO_OE_B),
        .GPIO_IN_B(GPIO_IN_B),

        .GPIO_OUT_C(GPIO_OUT_C),
        .GPIO_OE_C(GPIO_OE_C),
        .GPIO_IN_C(GPIO_IN_C)

    );

    // Simulate the GPIO
    tri [31:0] PORT_A;
    tri [31:0] PORT_B;
    tri [31:0] PORT_C;


    reg [31:0] temp_A;
    reg [31:0] temp_B;
    reg [31:0] temp_C;



    initial begin
        forever begin //using this to simulate a user changing input
            temp_A = $urandom_range(1, 100);
            temp_B = $urandom_range(1, 100);
            temp_C = $urandom_range(1, 100);

            #10000;
        end
    end

    assign PORT_A = GPIO_OE_A ? GPIO_OUT_A : temp_A;
    assign PORT_B = GPIO_OE_B ? GPIO_OUT_B : temp_B;
    assign PORT_C = GPIO_OE_C ? GPIO_OUT_C : temp_C;


    assign GPIO_IN_A = PORT_A;
    assign GPIO_IN_B = PORT_B;
    assign GPIO_IN_C = PORT_C;



    always @(PORT_C) begin
        #100;
        
        $display("Port_A: %d", PORT_A);
        $display("Port_B: %d", PORT_B);
        $display("Port_C: %d", PORT_C);

        if (PORT_C == (PORT_A + PORT_B)) begin
            $display("Success");
        end else begin
            $display("Failure");
        end
end



endmodule
