`include "defines.v"

module ALU_decoder(
    input [6:0] funct7,
    input [2:0] funct3,
    input [1:0] ALUOp,
    output reg [3:0] alu_control
);
    always @(*) begin
        case (ALUOp)
            2'b00: // R-Type lệnh (ADD, SUB, SLL, SLT, ...), dùng cả funct3 và funct7
                case (funct3)
                    `FUNCT3_ADD_SUB: alu_control = (funct7 == `FUNCT7_SUB) ? `ALU_SUB : `ALU_ADD;
                    `FUNCT3_SLL:     alu_control = `ALU_SLL;
                    `FUNCT3_SLT:     alu_control = `ALU_SLT;
                    `FUNCT3_SLTU:    alu_control = `ALU_SLTU;
                    `FUNCT3_XOR:     alu_control = `ALU_XOR;
                    `FUNCT3_SRL_SRA: alu_control = (funct7 == `FUNCT7_SRA) ? `ALU_SRA : `ALU_SRL;
                    `FUNCT3_OR:      alu_control = `ALU_OR;
                    `FUNCT3_AND:     alu_control = `ALU_AND;
                    default:         alu_control = 4'bxxxx;
                endcase
            2'b01:  // Dành cho các lệnh cần cộng địa chỉ: lw, sw, auipc, jal, jalr → dùng ALU để cộng
                alu_control = `ALU_ADD;
            2'b10: // I-Type Arithmetic (ADDI, SLTI, ANDI, SLLI, SRLI, SRAI,...)
                case (funct3)
                    `FUNCT3_ADDI:       alu_control = `ALU_ADD;
                    `FUNCT3_SLTI:      alu_control = `ALU_SLT;
                    `FUNCT3_SLTIU:     alu_control = `ALU_SLTU;
                    `FUNCT3_XORI:      alu_control = `ALU_XOR;
                    `FUNCT3_ORI:       alu_control = `ALU_OR;
                    `FUNCT3_ANDI:      alu_control = `ALU_AND;
                    `FUNCT3_SLLI:      alu_control = `ALU_SLL;
                    `FUNCT3_SRLI_SRAI: alu_control = (funct7 == `FUNCT7_SRA) ? `ALU_SRA : `ALU_SRL;
                    default:           alu_control = 4'bxxxx;
                endcase
            2'b11: // Dành cho lệnh nhánh (branch) – không cần điều khiển ALU cụ thể ở đây
                alu_control = 4'bxxxx;
            default: alu_control = 4'bxxxx;    // Trường hợp ALUOp không hợp lệ
        endcase
    end
endmodule
