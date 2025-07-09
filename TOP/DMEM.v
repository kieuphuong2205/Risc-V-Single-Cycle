module DMEM(
    input         clk,
    input  [31:0] address,
    input  [31:0] write_data,
    input         MemRW,
    output reg [31:0] read_data
);
    reg [31:0] memory [0:1023];            // Mảng 1024 ô nhớ, mỗi ô 32 bit → tổng 4KB

    always @(*) begin
        read_data = memory[address[11:2]];    // Dùng address[11:2] vì mỗi ô là 4 byte (2^2), bỏ 2 bit cuối để word-align
    end

    always @(posedge clk) begin        // Ghi dữ liệu đồng bộ với cạnh lên của clock
        if (MemRW) begin
            memory[address[11:2]] <= write_data;
        end
    end
endmodule
