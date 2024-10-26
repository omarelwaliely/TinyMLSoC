module ahbl_rom (
    input   wire        HCLK,
    input   wire        HRESETn,

    input   wire [31:0] HADDR,
    input   wire     	HREADY,
    input   wire        HSEL,
    input   wire [31:0] HWDATA,

    input   wire        read_uart,


    output  wire        HREADYOUT,
    output  wire [31:0] HRDATA
);

    parameter   SIZE = 64 * 1024;
    parameter   VERBOSE = 1;
    parameter   HEX_FILE = "test.hex";
    parameter   HEX_FILE2 = "test2.hex";
    localparam  A_WIDTH = $clog2(SIZE) - 2;

    reg [31:0] ROM[SIZE/4-1 : 0];

    reg [31:0] HADDR_d;
    reg        HSEL_d;
    reg rom_cleared;
    integer i;


    always @(posedge HCLK or negedge HRESETn) begin
        if(HRESETn == 1'b0) begin
            HADDR_d     <= 0;
            HSEL_d      <= 0;
            rom_cleared <= 0;
        end else if(HREADY == 1'b1) begin
            HADDR_d     <= HADDR;
            HSEL_d      <= HSEL;
        end 
    end

    always @(posedge HCLK or negedge HRESETn) begin
        if (read_uart) begin
            for (i = 0; i < SIZE/4; i = i + 1) begin
                ROM[i] <= 32'b0;
            end
            rom_cleared <= 1; 
        end
    end

    always @(posedge HCLK or negedge HRESETn) begin
        if (rom_cleared && !read_uart) begin
            $readmemh(HEX_FILE2, ROM);
            rom_cleared <= 0;
        end
    end

    assign HRDATA = ROM[HADDR_d[A_WIDTH-1 : 2]];

    assign HREADYOUT = 1'b1; // Always ready

    initial begin
        $readmemh(HEX_FILE, ROM);
    end

endmodule

