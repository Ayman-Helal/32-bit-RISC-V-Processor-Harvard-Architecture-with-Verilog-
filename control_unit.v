module control_unit(
    input   wire [6:0]  opcode,
    input   wire [2:0]  funct3,
    input   wire        funct75,
    input   wire        zero,
    output  wire        PCSrc,
    output  reg  [1:0]  ResultSrc,
    output  reg         MemWrite,
    output  reg         ALUsrc,
    output  reg  [1:0]  ImmSrc,
    output  reg         RegWrite,    
    output  reg  [2:0]  ALU_control   
);

reg  [1:0]  ALUout;
reg         branch,jump;

assign PCSrc = (zero & branch) | jump;

// Main Decoder 
 always @(*) begin
     case(opcode)
      7'b000_0011: begin
        RegWrite  = 1'b1;
        ImmSrc    = 2'b00;
        ALUsrc    = 1'b1;
        MemWrite  = 1'b0;
        ResultSrc = 2'b01;
        branch   = 1'b0;
        ALUout   = 2'b00;
        jump     = 1'b0;
         
      end 
      7'b010_0011: begin
        RegWrite  = 1'b0;
        ImmSrc    = 2'b01;
        ALUsrc    = 1'b1;
        MemWrite  = 1'b1;
        ResultSrc = 2'b00;
        branch   = 1'b0;
        ALUout   = 2'b00;
        jump     = 1'b0;
      end
      7'b011_0011: begin
        RegWrite  = 1'b1;
        ImmSrc    = 2'b00;
        ALUsrc    = 1'b0;
        MemWrite  = 1'b0;
        ResultSrc = 2'b00;
        branch   = 1'b0;
        ALUout   = 2'b10;
        jump     = 1'b0;
      end
      7'b110_0011: begin
        RegWrite  = 1'b0;
        ImmSrc    = 2'b10;
        ALUsrc    = 1'b0;
        MemWrite  = 1'b0;
        ResultSrc = 2'b00;
        branch   = 1'b1;
        ALUout   = 2'b01;
        jump     = 1'b0;
      end
      7'b001_0011: begin
        RegWrite  = 1'b1;
        ImmSrc    = 2'b00;
        ALUsrc    = 1'b1;
        MemWrite  = 1'b0;
        ResultSrc = 2'b00;
        branch   = 1'b0;
        ALUout   = 2'b10;
        jump     = 1'b0;
      end
      7'b110_1111: begin
        RegWrite  = 1'b1;
        ImmSrc    = 2'b11;
        ALUsrc    = 1'b0;
        MemWrite  = 1'b0;
        ResultSrc = 2'b10;
        branch   = 1'b0;
        ALUout   = 2'b00;
        jump     = 1'b1;
      end
      default: begin
        RegWrite  = 1'b0;
        ImmSrc    = 2'b00;
        ALUsrc    = 1'b0;
        MemWrite  = 1'b0;
        ResultSrc = 2'b00;
        branch   = 1'b0;
        ALUout   = 2'b00;
        jump     = 1'b0;
      end 
     endcase
 end

// ALU Decoder 

always @(*) begin

    case(ALUout)
    2'b00: ALU_control = 3'b000;
    2'b01: ALU_control = 3'b001;
    2'b10: begin
        case (funct3)
        3'b000: begin
            case ({opcode[5],funct75})
            2'b11:ALU_control = 3'b001;
            default:ALU_control = 3'b000;
            endcase        
        end 
        3'b010: ALU_control = 3'b101;
        3'b110: ALU_control = 3'b011;
        3'b111: ALU_control = 3'b010;
        default: ALU_control = 3'b000;
        endcase
    end 

    default: ALU_control = 3'b000;  
    endcase
    
end
endmodule 