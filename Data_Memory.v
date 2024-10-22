module Data_Memory(clk,rst,A,WD,RD,WE);

    input rst,clk,WE;
    input[31:0] A,WD;

    output [31:0] RD;

    reg[31:0] mem [1023:0];

    always@(posedge clk)
    begin
      if(WE)
      mem[A] <= WD;
    end

        assign RD = (~rst) ? 32'b0 : mem[A];
    
    initial begin
        mem[28] = 32'h00000020;
    end

endmodule