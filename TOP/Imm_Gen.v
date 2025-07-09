`include "defines.v"

module Imm_Gen(
    input  [31:0] instruction,
    output reg [31:0] immediate
);
    wire [6:0] opcode = instruction[6:0];    // Lấy opcode từ 7 bit thấp của instruction

    always @(*) begin
        case (opcode) // I-type: ADDI, ANDI, ORI, LW, JALR,...
            `OPCODE_I_ARITH, `OPCODE_LOAD, `OPCODE_JALR:
                immediate = {{20{instruction[31]}}, instruction[31:20]};
            `OPCODE_S:    // S-type: SW, SH, SB
                immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            `OPCODE_B:    // B-type: BEQ, BNE, BLT, BGE,...
                immediate = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
            `OPCODE_LUI, `OPCODE_AUIPC:    // U-type: LUI, AUIPC
                immediate = {instruction[31:12], 12'b0};
            `OPCODE_JAL:    // J-type: JAL
                immediate = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
            default:
                immediate = 32'hdeadbeef;    // Giá trị mặc định dễ nhận biết lỗi
        endcase
    end
endmodule
