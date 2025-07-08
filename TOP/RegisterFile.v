// --- File: RegisterFile.v ---
module RegisterFile(
    input         clk,
    input         RegWEn,
    input  [4:0]  rs1_addr,
    input  [4:0]  rs2_addr,
    input  [4:0]  rd_addr,
    input  [31:0] rd_data,
    output [31:0] rs1_data,
    output [31:0] rs2_data,
    output [31:0] registers_out [31:0]
);
    //reg [31:0] registers [31:0];
    (* keep *) reg [31:0] registers [31:0];

    initial begin
        integer i;
        for (i = 0; i < 32; i = i + 1)
            registers[i] = 32'd0;
    end

    assign rs1_data = (rs1_addr == 5'b0) ? 32'd0 : registers[rs1_addr];
    assign rs2_data = (rs2_addr == 5'b0) ? 32'd0 : registers[rs2_addr];

    always @(posedge clk) begin
        if (RegWEn && (rd_addr != 5'b0)) begin
            registers[rd_addr] <= rd_data;
        end
    end

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : reg_out_loop
            assign registers_out[i] = registers[i];
        end
    endgenerate
    
endmodule
