module ram (
    input [31:0]      WD,
    input [31:0]      addr,
    input             WE,clk,rst,
    output reg [31:0] RD,
    output reg [15:0] test_value
);

reg [31:0] memory [99:0];


always @(posedge clk, negedge rst) begin
    if (!rst) begin 
        RD <= 32'b0;
        test_value <= 16'b0;
    end
    else if (WE) begin 
        memory[addr] <= WD;
    end 
         
end

always @(addr) begin
  RD = memory[addr];
  test_value = memory[32'b0][16:0];  
end

endmodule 