module ahbl_rom (
    input   wire        HCLK,
    input   wire        HRESETn,

    input   wire [31:0] HADDR,
    input   wire [1:0]  HTRANS,
    input   wire     	HREADY,
    input   wire [2:0]  HSIZE,
    input   wire        HWRITE,
    input   wire        HSEL,
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

    wire ahbl_we        = HTRANS_d[1] & HSEL_d & HWRITE_d;

    // Data Size Decoder
    wire ds_byte = (HSIZE_d == 3'b000); 
    wire ds_half = (HSIZE_d == 3'b001);
    wire ds_word = (HSIZE_d == 3'b010);

    // Byte Location within the Memory Word
    wire byte_at_00 = ds_byte & (HADDR_d[1:0] == 2'b00);
    wire byte_at_01 = ds_byte & (HADDR_d[1:0] == 2'b01);
    wire byte_at_10 = ds_byte & (HADDR_d[1:0] == 2'b10);
    wire byte_at_11 = ds_byte & (HADDR_d[1:0] == 2'b11);

    // Half-word Location within the Memory Word
    wire half_at_00 = ds_half & ~HADDR_d[1];
    wire half_at_10 = ds_half &  HADDR_d[1];

    wire word_at_00 = ds_word;

    // Which byte to write -- Byte write enables
    wire byte0 = word_at_00 | half_at_00 | byte_at_00;
    wire byte1 = word_at_00 | half_at_00 | byte_at_01;
    wire byte2 = word_at_00 | half_at_10 | byte_at_10;
    wire byte3 = word_at_00 | half_at_10 | byte_at_11;


    assign HRDATA = ROM[HADDR_d[A_WIDTH-1 : 2]];

    assign HREADYOUT = 1'b1; // Always ready

    initial begin
        $readmemh(HEX_FILE, ROM);
    end

endmodule

