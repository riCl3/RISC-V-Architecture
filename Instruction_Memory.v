module Instruction_Memory(A, RD, rst);
    input[31:0] A;
    input rst;
    output[31:0] RD;

    reg[31:0] Mem [1023:0];

    assign RD = (rst == 1'b0) ? 32'h00000000 : Mem[A[31:2]];

endmodule