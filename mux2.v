module mux2
#(parameter WIDTH =32)


(

input wire sel,
input wire [WIDTH-1:0] IN0,
input wire [WIDTH-1:0] IN1,
output reg [WIDTH-1:0] out

);


always @ (*)

begin

  if(sel)
    begin
      out = IN1; 
    end 
  else begin 
      out = IN0; 
    end

end 

endmodule