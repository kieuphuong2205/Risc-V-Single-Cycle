module IMEM(
    input  [31:0] address,
    output reg [31:0] instruction
);
    reg [31:0] memory [0:1023];    // Mảng 1024 ô nhớ (word), mỗi ô 32-bit → tổng 4KB instruction memory

    initial begin
        $readmemh("program.hex", memory); // Tải nội dung từ file "program.hex" vào bộ nhớ instruction
    end

    always @(*) begin    // Đọc lệnh bất đồng bộ: lấy lệnh tại địa chỉ word-aligned
        instruction = memory[address[11:2]];
    end
endmodule
