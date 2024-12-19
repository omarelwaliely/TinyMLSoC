module ahbl_gpio_splitter #(parameter  A=4'h0, 
                                    B=4'h1,
                                    C = 4'h2,
                                    timer = 4'h3,
                                    i2s = 4'h4
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
    input   wire        C_HREADYOUT,

    // timer
    output  wire        timer_SEL,
    input   wire [31:0] timer_HRDATA,
    input   wire        timer_HREADYOUT,

    // i2s
    output  wire        i2s_SEL,
    input   wire [31:0] i2s_HRDATA,
    input   wire        i2s_HREADYOUT

);

    // The Decoder
    reg [4:0] sel;
    reg [4:0] sel_d;
    always @*
        case(HADDR[27:24])
            A: sel = 5'b00001;
            B: sel = 5'b00010;
            C: sel = 5'b00100;
            timer: sel = 5'b01000;
            i2s: sel = 5'b10000;
            default: sel = 5'b00000;
        endcase
    assign A_SEL = sel[0];
    assign B_SEL = sel[1];
    assign C_SEL = sel[2];
    assign timer_SEL = sel[3];
    assign i2s_SEL = sel[4];
    // The Slave MUX Selection Saving
    always@(posedge HCLK or negedge HRESETn) begin
        if(~HRESETn) begin
            sel_d <= 5'b00000;
        end else if(HTRANS[1] & HREADY) begin
            sel_d <= sel;
        end
    end
    assign HREADYOUT = 1'b1;
    assign HREADY =     (sel_d[0])  ?   A_HREADYOUT :
                        (sel_d[1])  ?   B_HREADYOUT :
                        (sel_d[2])  ?   C_HREADYOUT :
                        (sel_d[3])  ?   timer_HREADYOUT :
                        (sel_d[4])  ?   i2s_HREADYOUT :
                        1'b1;

    assign HRDATA =   (sel_d[0])  ?   A_HRDATA :
                        (sel_d[1])  ?   B_HRDATA :
                        (sel_d[2])  ?   C_HRDATA :
                        (sel_d[3])  ?   timer_HRDATA :
                        (sel_d[4])  ?   i2s_HRDATA :
                        32'hBADDBEEF;

endmodule