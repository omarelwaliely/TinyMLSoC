module fifo_tb;

    // Parameters
    localparam DW = 32;  
    localparam AW = 4;  // 16 slots i hope
    //32 x 16 fifo

    // Signals
    reg clk;
    reg rst_n;
    reg rd;
    reg wr;
    reg flush;
    reg [DW-1:0] wdata;
    reg [DW-1:0] data_array [0:AW*4];
    wire empty;
    wire full;
    wire [DW-1:0] rdata;
    wire [AW-1:0] level;
    integer i;

    aucohl_fifo #(DW, AW) fifo_inst (
        .clk(clk),
        .rst_n(rst_n),
        .rd(rd),
        .wr(wr),
        .flush(flush),
        .wdata(wdata),
        .empty(empty),
        .full(full),
        .rdata(rdata),
        .level(level)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, fifo_tb);

        clk = 0;
        rst_n = 0;
        rd = 0;
        wr = 0;
        flush = 0;
        wdata = 0;
        data_array[0] = 32'hAAAA_BBBB;
        data_array[1] = 32'hCCCC_DDDD;
        data_array[2] = 32'hEEEE_FFFF;
        data_array[3] = 32'h1111_2222;
        data_array[4] = 32'h3333_4444;
        data_array[5] = 32'h5555_6666;
        data_array[6] = 32'h7777_8888;
        data_array[7] = 32'h9999_AAAA;
        data_array[8] = 32'hBBBB_CCCC;
        data_array[9] = 32'hDDDD_EEEE;
        data_array[10] = 32'hFFFF_0000;
        data_array[11] = 32'h1234_5678;
        data_array[12] = 32'h9ABC_DEF0;
        data_array[13] = 32'h1357_2468;
        data_array[14] = 32'hFEDC_BA98;
        data_array[15] = 32'h7654_3210;

        #10 rst_n = 1;

        for (i = 0; i < 16; i = i + 1) begin
            #10 wdata = data_array[i];
            wr = 1;
        end
        
        #10 wr = 0;
        // should be full now
        #10 rd = 1; 
        repeat (16) begin
            #10;
        end
        //shoukd be empty now
        #10 rd = 0;
        #10
        wdata = data_array[0];            
        wr = 1;
        //should stop being empty nows

        #50 $finish;
    end

endmodule
