module alu(
    input wire [31:0] srcA,
    input wire [31:0] srcB,
    input wire [2:0]  alu_control,
    output reg        zero_flag,
    output reg [31:0] alu_out   
);

always @(*) 
begin
    case(alu_control)
    3'b000: alu_out = srcA + srcB;
    3'b001: alu_out = srcA - srcB;
    3'b101:begin
        if(srcA<srcB)
         alu_out = 32'd1;
         else 
         alu_out = 32'd0;
           end
    3'b011: alu_out = srcA | srcB;
    3'b010: alu_out = srcA & srcB;
    default: alu_out = 32'b0;  
    endcase
end

always @(*) 
 begin
     if (alu_out == 32'b0 )
     begin
         zero_flag = 1'b1;
     end
     else 
     begin
         zero_flag = 1'b0;
     end  
    
 end

 endmodule