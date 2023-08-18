addi  x5 , x5 ,300    
addi  x1 , x1 , 1     
loop:
addi x2,  x2 , 1     
add  x3,  x3 , x2    
sw   x3,  0(a6)         
slt  x4,  x3 , x5    
lw   t6,  0(a6)     
beq  x4, x1, loop    
jal  x10, 24         