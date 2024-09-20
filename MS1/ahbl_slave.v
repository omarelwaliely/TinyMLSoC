module ahbl_slave #(parameter ID = 32'hABCD_EF00) (
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
    output wire [31:0] register_0_output,
    output wire [31:0] register_1_output,
    output wire [31:0] register_2_output,    
);
    reg [31:0] HADDR_d;
    reg [1:0]  HTRANS_d;
    reg [2:0]  HSIZE_d;
    reg        HWRITE_d;
    reg        HSEL_d;
    reg[2:0] load;
    
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
   always @(posedge HCLK) begin
        if (HRESETn & ahbl_we) begin
            $display("Slave %h: WRITE 0x%8x to 0x%8x", ID, HWDATA, HADDR_d);
            case (HADDR_d[27:24])
                4'd0: load <= 3'b100;
                4'd1: load <= 3'b010;
                4'd2: load <= 3'b001; 
                default: load <= 3'b100;
            endcase
        end else begin
            load <= 3'b000;
        end
    end

    register register_0(
        .clk(HCLK),
        .rst_n(HRESETn),
        .load(load[0]),
        .D(HWDATA),
        .Q(register_0_output)
    );

    register register_1(
        .clk(HCLK),
        .rst_n(HRESETn),
        .load(load[1]),
        .D(HWDATA),
        .Q(register_1_output)
    );

    register register_2(
        .clk(HCLK),
        .rst_n(HRESETn),
        .load(load[2]),
        .D(HWDATA),
        .Q(register_2_output)
    );
    assign HREADYOUT = 1;
    assign HRDATA = ID;
endmodule
