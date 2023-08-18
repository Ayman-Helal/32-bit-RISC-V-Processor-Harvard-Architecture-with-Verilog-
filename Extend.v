module Extend (
    input wire      [31:7] ext_in,
    input wire      [1:0]  immsrc,
    output reg      [31:0] ext_out 
);

always @(*) begin
    case(immsrc)
    2'b00: ext_out = {{20{ext_in[31]}}, ext_in[31:20]};
    2'b01: ext_out = {{20{ext_in[31]}}, ext_in[31:25], ext_in[11:7]};
    2'b10: ext_out = {{20{ext_in[31]}}, ext_in[7], ext_in[30:25], ext_in[11:8], 1'b0};
    2'b11: ext_out = {{12{ext_in[31]}}, ext_in[19:12], ext_in[20], ext_in[30:21], 1'b0};
    default: ext_out = 32'b0;  
    endcase
end

endmodule 