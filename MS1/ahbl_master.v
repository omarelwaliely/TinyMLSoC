module ahbl_master (
    input   wire        HCLK,
    input   wire        HRESETn,
    output  reg  [31:0] HADDR,
    output  reg  [1:0]  HTRANS,
    output  reg  [2:0] 	HSIZE,
    output  reg         HWRITE,
    output  reg  [31:0] HWDATA,
    input   wire        HREADY,
    input   wire [31:0] HRDATA
);

    task ahbl_read;
    input [31:0]    addr;
    input [2:0]     size;
    begin
        wait (HREADY == 1'b1);
        // Address Phase
        @(posedge HCLK);
        #1;
        HTRANS = 2'b10;
        HADDR = addr;
        HWRITE = 1'b0;
        HSIZE = size;
        @(posedge HCLK);
        HTRANS = 2'b00;
        wait (HREADY == 1'b1);
        @(negedge HCLK) begin
            if(size == 0) 
                #1 $display("Read 0x%8x from 0x%8x", HRDATA & 32'hFF, addr);
            else if(size == 1) 
                #1 $display("Read 0x%8x from 0x%8x", HRDATA & 32'hFFFF, addr);
            else if(size == 2)
                #1 $display("Read 0x%8x from 0x%8x", HRDATA, addr);
        end
    end
    endtask

    task ahbl_w_write;
    input [31:0]    addr;
    input [31:0]    data;
    input [2:0]     size;
    begin
        wait (HREADY == 1'b1);
        // Address Phase
        @(posedge HCLK);
        #1;
        HTRANS = 2'b10;
        HADDR = addr;
        HSIZE = size;
        HWRITE = 1'b1;
        // Data phase
        @(posedge HCLK);
        HWDATA = data;
        HTRANS = 2'b00;
        #2;
        wait (HREADY == 1'b1);
    end
    endtask

    initial begin
        @(posedge HRESETn);
        #100;

        //test peripheral
        ahbl_w_write(32'h40_000001, 32'h00000001, 2);
        ahbl_w_write(32'h40_000002, 32'h00000002, 2);
        $display("----------writing done (peripheral)-----------");

        #200;
        // Do some reads
        
        ahbl_read(32'h40_000002, 2);
        ahbl_read(32'h40_000001, 2);
        ahbl_read(32'h40_000003, 2);
        $display("-----------reading done (peripheral) ----------------");

        #200;
        //test RAM 
        ahbl_w_write(32'h00_000001, 32'h50000033, 2);
        ahbl_w_write(32'h20_000002, 32'h00000004, 2);
        ahbl_w_write(32'h00_000004, 32'hAABBCCDD, 0); 
        ahbl_w_write(32'h00_000008, 32'h00DBDBDB, 1); 

        $display("----------writing done (RAM)-----------");

        #100;
        ahbl_read(32'h00_000001, 2);
        ahbl_read(32'h20_000002, 2);
        ahbl_read(32'h20_000101, 2);
        ahbl_read(32'h00_000004, 2); 
        ahbl_read(32'h00_000004, 1);
        ahbl_read(32'h00_000006, 1); 
        ahbl_read(32'h00_000008, 0);
        ahbl_read(32'h00_000008, 1);
        ahbl_read(32'h00_000008, 2);
        $display("----------writing done (RAM)-----------");





        //ahbl_read(32'h40_000000, 2);
        //ahbl_read(32'h40_000000, 2);


        
        

        // terminate the simulation 
        #100;
        
        $finish;
    end

endmodule