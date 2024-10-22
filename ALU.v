module ALU(A,B,ALUControl,Result,Zero,Negative,OverFlow,Carry);
    //declaring inputs
    input[31:0] A,B;
    input[2:0] ALUControl;
    //declaring outputs
    output[31:0] Result;
    output Zero,Negative,OverFlow,Carry;
    //declaring wires
    wire[31:0] a_and_b;
    wire[31:0] a_or_b;
    wire[31:0] not_b;
    wire[31:0] mux_1;
    wire[31:0] mux_2;
    wire[31:0] sum;
    wire[31:0] slt; //For Zero Extension
    wire cout;

    //Logic Design
    assign a_and_b = A & B;
    assign a_or_b = A | B;
    assign not_b = ~B;
    assign mux_1 = (ALUControl[0] == 1'b0) ? B : not_b;
    assign {cout,sum} = A + mux_1 + ALUControl[0];  
    assign mux_2 = (ALUControl[2:0] == 3'b000) ? sum : 
                   (ALUControl[2:0] == 3'b001) ? sum : 
                   (ALUControl[2:0] == 3'b010) ? a_and_b :
                   (ALUControl[2:0] == 3'b011) ? a_or_b :
                   (ALUControl[2:0] == 3'b101) ? slt : 32'h00000000;
                   
    assign Result = mux_2;

    //Zero Extenstion
    assign slt = {31'b0, sum[31]};
    //Assignment of Flag
    //Zero FLag
    assign Zero = &(~Result);
    //Negative OverFlowerFlowe Flag
    assign Negative = Result[31];
    //Carry Flag
    assign Carry = cout & (~ALUControl[1]);
    //OverFlowerFlowerflow FLag
    assign OverFlowerFlow = (A[31] ^ sum[31]) & (~ALUControl[1]) & (~(A[31] ^ B[31] ^ ALUControl[0]));
endmodule