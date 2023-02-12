`timescale 1ns / 1ps

module SIMDadd(
        input [15:0] A,
        input [15:0] B,
        input H,//1-bit signal for 16-bits data
        input O,//1-bit signal for 8-bits data
        input Q,//1-bit signal for 4-bits data
        input sub,//1-bit
		//output
        output [15:0] Cout
    );
    wire [15:0] B_real = sub?(~B):B;//Two's complement 
    wire [4:0] C0 = A[3:0]   +  B_real[3:0]    + sub;
    wire [4:0] C1 = A[7:4]   +  B_real[7:4]    + (C0[4]&(O|H)) + (Q&sub);
    wire [4:0] C2 = A[11:8]  +  B_real[11:8]   + (C1[4]&H)     + ((Q|O)&sub);
    wire [4:0] C3 = A[15:12] +  B_real[15:12]  + (C2[4]&(O|H)) + (Q&sub);
    
    assign Cout = {C3[3:0],C2[3:0],C1[3:0],C0[3:0]};
    
    
endmodule
