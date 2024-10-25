/*
    A 32-bit Timer Port
*/

module ahbl_timer(
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
    output  wire [31:0] HRDATA,
    
    output wire [31:0]   TIMER_OUT
);

localparam  TIMER_STATUS = 'h00,
            LOAD_VALUE  = 'h04;
            

reg [32:0]  HADDR_d;
reg [2:0]   HSIZE_d;
reg [1:0]   HTRANS_d;
reg         HWRITE_d;
reg         HSEL_d;

wire TIMER_STATUS_sel   = (HADDR_d[7:0] == TIMER_STATUS);
wire LOAD_VALUE_sel    = (HADDR_d[7:0] == LOAD_VALUE);

wire ahbl_we        = HTRANS_d[1] & HSEL_d & HWRITE_d;


    /*
    As of right now timer works by waiting for status register to contain "1" in order to start you must write "1" 
    and you must have loaded a value before that at anytime after reset.
    */

always @(posedge HCLK) begin
    if(!HRESETn) begin
        HADDR_d     <= 'h0;
        HSIZE_d     <= 'h0;
        HTRANS_d    <= 'h00;
        HWRITE_d    <= 'h0;
        HSEL_d      <= 'h00;
    end else if(HREADY) begin
        HADDR_d     <= HADDR;
        HSIZE_d     <= HSIZE;
        HTRANS_d    <= HTRANS;
        HWRITE_d    <= HWRITE;
        HSEL_d      <= HSEL;
    end
end


reg [31:0] TIMER_STATUS_REG, LOAD_VALUE_REG;

always @ (posedge HCLK or negedge HRESETn)begin
    if(~HRESETn) begin
        TIMER_STATUS_REG <= 'h0;
    end
    else if(ahbl_we & TIMER_STATUS_sel)begin 
        TIMER_STATUS_REG <= HWDATA;
    end
    else if(TIMER_STATUS_sel) begin
        TIMER_STATUS_REG[8] <= (TIMER_OUT ==0);
    end
    else TIMER_STATUS_REG[0] <= 'h0;
end
            
            
always @ (posedge HCLK or negedge HRESETn)begin
    if(~HRESETn)begin
        LOAD_VALUE_REG <= 'h0;
    end
    else if(ahbl_we & LOAD_VALUE_sel) begin
        LOAD_VALUE_REG <= HWDATA;
    end
end

upcounter upcount (
    .clk(HCLK),
    .rst_n(HRESETn),
    .start((TIMER_STATUS_REG[0])),
    .count(TIMER_OUT),
    .load(LOAD_VALUE_REG)
);

assign HRDATA = TIMER_STATUS_sel ? TIMER_STATUS_REG :
                LOAD_VALUE_sel  ? LOAD_VALUE_REG :
                32'hBADDBEEF;

assign HREADYOUT = 1'b1;

endmodule