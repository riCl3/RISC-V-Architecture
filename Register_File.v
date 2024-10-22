module Register_File(A1,A2,A3,RD1,RD2,WD3,WE3,clk,rst);

    input[4:0] A1,A2,A3;
    input[31:0] WD3;
    input clk,rst,WE3;

    output[31:0] RD1,RD2;

    //Memory Creation
    reg[31:0] Register [31:0];

    //Read Functionality
    always@(posedge clk)
     begin
       if(WE3)
            Register[A3] <= WD3;
     end 

     assign RD1 = (~rst) ? 32'd0 : Register[A1];
     assign RD2 = (~rst) ? 32'd0 : Register[A2];

     initial begin
        Register[5] = 32'h00000005;
        Register[6] = 32'h00000004;
        
    end

endmodule