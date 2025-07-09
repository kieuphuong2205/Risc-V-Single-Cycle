`include "defines.v"

module ALU(
    input  [31:0] A,
    input  [31:0] B,
    input  [3:0]  ALUControl,
    output reg [31:0] Result
);
    always @(*) begin            // Khối always luôn chạy khi có bất kỳ thay đổi nào ở A, B, hoặc ALUControl
        case (ALUControl)        // Chọn phép toán dựa trên giá trị ALUControl
            `ALU_ADD:  Result = A + B;        // Cộng hai số
            `ALU_SUB:  Result = A - B;        // Trừ A - B
            `ALU_SLL:  Result = A << B[4:0];  // Dịch trái A theo số bit trong B[4:0]
            `ALU_SLT:  Result = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0;     //So sánh nhỏ hơn (có dấu)
            `ALU_SLTU: Result = (A < B) ? 32'd1 : 32'd0;        // So sánh nhỏ hơn (không dấu)
            `ALU_XOR:  Result = A ^ B;                          // Phép XOR bitwise
            `ALU_SRL:  Result = A >> B[4:0];                    // Dịch phải (không dấu) A theo B[4:0]
            `ALU_SRA:  Result = $signed(A) >>> B[4:0];          // Dịch phải (có dấu, bảo toàn bit dấu)
            `ALU_OR:   Result = A | B;                          // Phép OR bitwise
            `ALU_AND:  Result = A & B;                          // Phép AND bitwise 
            default:   Result = 32'hdeadbeef;                   // Mặc định trả về giá trị đặc biệt để dễ debug nếu ALUControl không hợp lệ
        endcase
    end
endmodule
