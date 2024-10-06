module ahbl_gpio_splitter #(parameter  A=3'h0, 
                                    B=3'h1,
                                    C = 3'h2
                                    )
(
    input   wire        HCLK,
    input   wire        HRESETn,

    // BUS
    input   wire [31:0] HADDR,
    input   wire [1:0]  HTRANS,
    output  wire        HREADY,
    output  wire [31:0] HRDATA,
    output wire HREADYOUT,
    input   wire        HSEL,


    // GPIO A
    output  wire        A_SEL,
    input   wire [31:0] A_HRDATA,
    input   wire        A_HREADYOUT,

    // GPIO B
    output  wire        B_SEL,
    input   wire [31:0] B_HRDATA,
    input   wire        B_HREADYOUT,

    // GPIO C
    output  wire        C_SEL,
    input   wire [31:0] C_HRDATA,
    input   wire        C_HREADYOUT

);

    // The Decoder
    reg [2:0] sel;
    reg [2:0] sel_d;
    always @*
        case(HADDR[27:24])
            A: sel = 3'b001;
            B: sel = 3'b010;
            C: sel = 3'b100;
            default: sel = 3'b000;
        endcase
    assign A_SEL = sel[0];
    assign B_SEL = sel[1];
    assign C_SEL = sel[2];

    // The Slave MUX Selection Saving
    always@(posedge HCLK or negedge HRESETn) begin
        if(~HRESETn) begin
            sel_d <= 3'b000;
        end else if(HTRANS[1] & HREADY) begin
            sel_d <= sel;
        end
    end
    assign HREADYOUT = 1'b1;
    assign HREADY =     (sel_d[0])  ?   A_HREADYOUT :
                        (sel_d[1])  ?   B_HREADYOUT :
                        (sel_d[2])  ?   C_HREADYOUT :
                        1'b1;

    assign HRDATA =   (sel_d[0])  ?   A_HRDATA :
                        (sel_d[1])  ?   B_HRDATA :
                        (sel_d[2])  ?   C_HRDATA :
                        32'hBADDBEEF;

endmodule