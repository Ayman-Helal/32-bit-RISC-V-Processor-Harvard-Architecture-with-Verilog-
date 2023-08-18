module RISC (
    input  wire        clk,
    input  wire        rst,
    output wire [15:0] test_value
 );

wire  [6:0]  opcode_r;
wire  [2:0]  funct3_r;
wire         funct75_r;
wire         zero_r;
wire         PCSrc_r;
wire  [1:0]  ResultSrc_r;
wire         MemWrite_r;
wire         ALUsrc_r;
wire  [1:0]  ImmSrc_r;
wire         RegWrite_r;  
wire  [2:0]  ALU_control_r;

 // Control Unit 
 control_unit CUR(
    .opcode(opcode_r),
    .funct3(funct3_r),
    .funct75(funct75_r),
    .zero(zero_r),
    .PCSrc(PCSrc_r),
    .ResultSrc(ResultSrc_r),
    .MemWrite(MemWrite_r),
    .ALUsrc(ALUsrc_r),
    .ImmSrc(ImmSrc_r),
    .RegWrite(RegWrite_r),  
    .ALU_control(ALU_control_r)
 );


 //Data Path

 data_path DPUR (
    .clk(clk),
    .rst(rst),
    .PCSrc(PCSrc_r),
    .ResultSrc(ResultSrc_r),
    .MemWrite(MemWrite_r),
    .ALUcon(ALU_control_r),
    .ALUsrc(ALUsrc_r),
    .ImmSrc(ImmSrc_r),
    .RegWrite(RegWrite_r),
    .OP(opcode_r),
    .funct3(funct3_r),
    .funct75(funct75_r),
    .test_value(test_value),
    .zero(zero_r)
 );

endmodule