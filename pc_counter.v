module  pc_counter(

input wire [31:0]  PC_bar, 
input wire         clk,
input wire         rst,
output reg [31:0]  PC
);



always @(posedge clk, negedge rst) begin

    if(!rst) begin 
      PC <= 32'b0;
    end 

    else begin
      PC <= PC_bar;
    end 
end


endmodule 

