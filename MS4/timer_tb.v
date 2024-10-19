module timer_tb;
    reg          clk = 0;
    reg          rst_n = 0;
    reg          start;
    reg  [15:0]  load; 
    wire [15:0] count;
    upcounter upcount (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .count(count),
        .load(load)
    );
    always #10 clk = !clk;


    initial begin
        $dumpfile("timer_tb.vcd");
        $dumpvars;
    end

    initial begin
        rst_n = 0;
        #10;
        @(posedge clk);
        #1; 
        rst_n = 1;
        start =1;
        load = 32'd1000;
        #1000; 
        start =0;
        #100000;
        $finish;
    end
endmodule       
