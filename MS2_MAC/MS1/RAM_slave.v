// Create a slave module that represents a 8kbytes memory which supports byte, half-word and 
// word read and write (we will call this slave RAM) 
module RAM_slave #(parameter ID = 32'hABCD_EF00) (
    input   wire        HCLK,
    input   wire        HRESETn,

    input   wire [31:0] HADDR,
    input   wire [1:0]  HTRANS,
    input   wire     	HREADY,
    input   wire [2:0]  HSIZE,
    input   wire        HWRITE,
    input   wire        HSEL,
    input   wire [31:0] HWDATA,
    output  reg        HREADYOUT,
    output  reg [31:0] HRDATA
    
);

    // Create a byte addressable memory arry of 8KB
    reg [7:0] mem [0:8191];

    reg [31:0] HADDR_d;
    reg [1:0]  HTRANS_d;
    reg [2:0]  HSIZE_d;
    reg        HWRITE_d;
    reg        HSEL_d;
    always @(posedge HCLK or negedge HRESETn) begin
        if(HRESETn == 1'b0) begin
            HADDR_d     <= 0;
            HTRANS_d    <= 0;
            HSIZE_d     <= 0;
            HWRITE_d    <= 0;
            HSEL_d      <= 0;
        end else if(HREADY == 1'b1) begin
            HADDR_d     <= HADDR;
            HTRANS_d    <= HTRANS;
            HSIZE_d     <= HSIZE;
            HWRITE_d    <= HWRITE;
            HSEL_d      <= HSEL;
        end 
    end

    wire ahbl_we = HTRANS_d[1] & HSEL_d & HWRITE_d;
    wire ahbl_rd = HTRANS_d[1] & HSEL_d & ~HWRITE_d;

    // Write to memory
    // The memory is 8KB -> 13 bits of mem address (2^13 = 8192)
    // Memory is byte addressable
    always @(posedge HCLK) begin
        if(HRESETn & ahbl_we) begin
            HREADYOUT <= 0;
            case(HSIZE_d)
                3'b000: mem[HADDR[12:0]] <= HWDATA[7:0];
                3'b001: {mem[HADDR[12:0]+1], mem[HADDR[12:0]]} <= HWDATA[15:0];
                3'b010: {mem[HADDR[12:0]+3], mem[HADDR[12:0]+2], mem[HADDR[12:0]+1], mem[HADDR[12:0]]} <= HWDATA;
                default: mem[HADDR[12:0]] <= HWDATA;
            endcase
            $display("Slave %h: WRITE 0x%8x to 0x%8x", ID, HWDATA, HADDR_d);
            HREADYOUT <= 1;
        end
    end

    // Read from memory
    always @(posedge HCLK or negedge HRESETn) begin
        if(!HRESETn) begin
            HRDATA <= 0;
        end else if(ahbl_rd & HREADY) begin
            HREADYOUT <= 0;
            case(HSIZE_d)
                3'b000: HRDATA <= {24'b0, mem[HADDR[12:0]]};
                3'b001: HRDATA <= {16'b0, mem[HADDR[12:0]+1], mem[HADDR[12:0]]};
                3'b010: HRDATA <= {mem[HADDR[12:0]+3], mem[HADDR[12:0]+2], 
                                  mem[HADDR[12:0]+1], mem[HADDR[12:0]]};
                default: HRDATA <= mem[HADDR[12:0]];
            endcase
            HREADYOUT <= 1;
        end
    end
    // assign HRDATA = ID;
endmodule