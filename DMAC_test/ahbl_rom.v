module ahbl_rom (
    input   wire        HCLK,
    input   wire        HRESETn,

    input   wire [31:0] HADDR,
    input   wire     	HREADY,
    input   wire [31:0] HWDATA,

    output  wire        HREADYOUT,
    output  wire [31:0] HRDATA
);

    parameter   SIZE = 64 * 1024;
    parameter   VERBOSE = 1;
    parameter   HEX_FILE = "test.hex";
    localparam  A_WIDTH = $clog2(SIZE) - 2;

    reg [31:0] ROM[SIZE/4-1 : 0];

    reg [31:0] HADDR_d;

    always @(posedge HCLK or negedge HRESETn) begin
        if(HRESETn == 1'b0) begin
            HADDR_d     <= 0;
        end else if(HREADY == 1'b1) begin
            HADDR_d     <= HADDR;
        end 
    end

    assign HRDATA = ROM[HADDR_d[A_WIDTH-1 : 2]];

    assign HREADYOUT = 1'b1; // Always ready

    initial begin
        $readmemh(HEX_FILE, ROM);
    end

endmodule
