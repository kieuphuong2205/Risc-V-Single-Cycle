module Program_Counter(
    input clk,
    input rst_n,
    input  [31:0] pc_in,
    output reg [31:0] pc_out
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            pc_out <= 32'h00000000;     // Khi reset = 0 → đặt PC về 0
        else
            pc_out <= pc_in;            // Ngược lại, cập nhật PC theo giá trị đầu vào
    end
endmodule
