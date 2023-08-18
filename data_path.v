module data_path (
    input   wire          clk,
    input   wire          rst,
    input   wire          PCSrc,
    input   wire  [1:0]   ResultSrc,
    input   wire          MemWrite,
    input   wire  [2:0]   ALUcon,
    input   wire          ALUsrc,
    input   wire  [1:0]   ImmSrc,
    input   wire          RegWrite,
    output  wire  [6:0]   OP,
    output  wire  [2:0]   funct3,
    output  wire          funct75,
    output  wire  [15:0]  test_value,
    output  wire          zero
);

wire [31:0] PCNext,PCPlus4,PCtarget,PC;
wire [31:0] instrD, Result, srcA, srcB, WriteData;
wire [31:0] ImmExt, ALUResult,ReadData;


assign OP = instrD[6:0];
assign funct3 = instrD[14:12];
assign funct75 = instrD[30];

// mux1 

mux2  muxD1
(
     .sel(PCSrc),
     .IN0(PCPlus4),
     .IN1(PCtarget),
     .out(PCNext)

);

//PC

pc_counter pc_counterD(
    .PC_bar(PCNext), 
    .clk(clk),
    .rst(rst),
    .PC(PC)
);

// Adder1

adder adderD1 (
    .IN1(PC),
    .IN2(32'd4),
    .OUT(PCPlus4)
);

// Instruction memory

rom romD (
    .addr(PC),
    .Dout(instrD)
);




// Reg File 

reg_file reg_fileD(
    .A1(instrD[19:15]),
    .A2(instrD[24:20]),
    .A3(instrD[11:7]),
    .WD3(Result),
    .clk(clk),
    .rst(rst),
    .WE3(RegWrite),
    .RD1(srcA),
    .RD2(WriteData)  
);

// extend unit 

Extend ExtendD (
    .ext_in(instrD[31:7]),
    .immsrc(ImmSrc),
    .ext_out(ImmExt) 
);

// Adder2

adder adderD2 (
    .IN1(PC),
    .IN2(ImmExt),
    .OUT(PCtarget)
);

// Mux2 

mux2  muxD2
(
    .sel(ALUsrc),
    .IN0(WriteData),
    .IN1(ImmExt),
    .out(srcB)
);

// ALU

alu aluD(
    .srcA(srcA),
    .srcB(srcB),
    .alu_control(ALUcon),
    .zero_flag(zero),
    .alu_out(ALUResult)  
);

// Data Memory

ram ramD (
    .WD(WriteData),
    .addr(ALUResult),
    .WE(MemWrite),
    .clk(clk),
    .rst(rst),
    .RD(ReadData),
    .test_value(test_value)
);

// Mux 3 
mux4 muxD3(
    .IN0(ALUResult),
    .IN1(ReadData),
    .IN2(PCPlus4),
    .sel(ResultSrc),
    .OUT(Result)
);




endmodule