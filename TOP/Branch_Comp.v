`include "defines.v"

module Branch_Comp(
    input [31:0] A,            // Toán hạng thứ nhất (giá trị thanh ghi rs1)
    input [31:0] B,            // Toán hạng thứ hai (giá trị thanh ghi rs2)
    input        BrUn,         // Cờ chọn phép so sánh có dấu (0) hoặc không dấu (1) – hiện tại không dùng trong logic
    input [2:0]  funct3,       // Trường funct3 từ lệnh branch (BEQ, BNE, BLT,...)
    output reg   BranchTaken   // Cờ báo có thực hiện branch hay không (1: có nhảy, 0: không nhảy)

);
    always @(*) begin
        case (funct3)
            `FUNCT3_BEQ:  BranchTaken = (A == B);    // Branch nếu A == B
            `FUNCT3_BNE:  BranchTaken = (A != B);    // Branch nếu A != B
            `FUNCT3_BLT:  BranchTaken = ($signed(A) < $signed(B));    // Branch nếu A < B (có dấu)
            `FUNCT3_BGE:  BranchTaken = ($signed(A) >= $signed(B));    // Branch nếu A ≥ B (có dấu)
            `FUNCT3_BLTU: BranchTaken = (A < B);         // Branch nếu A < B (không dấu) 
            `FUNCT3_BGEU: BranchTaken = (A >= B);        // Branch nếu A ≥ B (không dấu) 
            default:      BranchTaken = 1'b0;            // Mặc định không nhảy nếu funct3 không hợp lệ
        endcase
    end
endmodule
