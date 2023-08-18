module rom (
    input      [31:0]  addr ,
    output reg [31:0]  Dout
);

reg [31:0] mem [99:0];

initial 
    begin
        $readmemh ("Program_Machine_Code.txt", mem);
    end

always @(addr) begin
    Dout = mem[addr>>2];
    
end
endmodule
