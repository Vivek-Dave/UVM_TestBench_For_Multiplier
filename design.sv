module mul(in1,
           in2,
           clk,
           out
           );
    
   parameter N=8;

   input [N-1:0]  in1,in2;
   input              clk;
  	output [(2*N)-1:0] out;
  	reg[(2*N)-1:0]     temp;

  	assign out=temp;
  
  	always@(posedge clk)
        begin
           temp=in1*in2;
        end

endmodule