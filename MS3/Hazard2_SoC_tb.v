module Hazard2_SoC_tb;
    reg         HCLK;
    reg         HRESETn;

    wire [31:0] GPIO_OUT_1;
    wire [31:0] GPIO_OE_1;
    wire [31:0] GPIO_IN_1;

    wire [31:0] GPIO_OUT_2;
    wire [31:0] GPIO_OE_2;
    wire [31:0] GPIO_IN_2;

    
    wire [31:0] GPIO_OUT_3;
    wire [31:0] GPIO_OE_3;
    wire [31:0] GPIO_IN_3;
    
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

        .GPIO_OUT_1(GPIO_OUT_1),
        .GPIO_OE_1(GPIO_OE_1),
        .GPIO_IN_1(GPIO_IN_1),

        .GPIO_OUT_2(GPIO_OUT_2),
        .GPIO_OE_2(GPIO_OE_2),
        .GPIO_IN_2(GPIO_IN_2),

        .GPIO_OUT_3(GPIO_OUT_3),
        .GPIO_OE_3(GPIO_OE_3),
        .GPIO_IN_3(GPIO_IN_3)

    );

    // Simulate the GPIO
    tri [31:0] PORT_1;
    tri [31:0] PORT_2;
    tri [31:0] PORT_3;




    assign PORT_1 = GPIO_OE_1 ? 32'hZZZZ_ZZZZ : GPIO_OUT_1;
    assign PORT_2 = GPIO_OE_2 ? 32'hZZZZ_ZZZZ : GPIO_OUT_2;
    assign PORT_3 = GPIO_OE_3 ? GPIO_OUT_3 : 32'hZZZZ_ZZZZ;


    assign GPIO_IN_1 = PORT_1;
    assign GPIO_IN_2 = PORT_2;
    assign GPIO_IN_3 = PORT_3;



    always @(PORT_1) begin
     
        #100; 

          
        if (PORT_3 == (PORT_1 + PORT_2)) begin
            $display(PORT_1);
            $display(PORT_2);
            $display(PORT_3);
            $display("Test Passed");
        end 

end



endmodule