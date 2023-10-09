.data:
    nextline: .string "\n"
    input_size: .word 4
    data_1: .word 0b00000000000000000000000000000001
    data_2: .word 0b00000000000000000000000000000011
    data_3: .word 0b00000000000000000000000000000100
    data_4: .word 0b00000000000000000000000000001001
    
main:
    addi sp, sp, -20
    
    # push four pointers of test data onto the stack
    lw t0, data_1
    sw t0, 0(sp)
    lw t0, data_2
    sw t0, 4(sp)
    lw t0, data_3
    sw t0, 8(sp)
    lw t0, data_4
    sw t0, 12(sp)
    
    addi s0, x0, 4    # s0 is the iteration times(4 test case)
    addi s1, x0, 0    # s1 is counter
    addi s2, sp, 0    # s2 initial at data_1

loop:
    lw a0, 0(s2)        #load data into a0
    addi s2, s2, 4      # s2 move to next data
    addi s1, s1, 1      # counter++
clz:
    # Load the constants A01, A02, and mask 0x0f0f0f0f
    lui a5, 0x55555
    ori a5, a5, 0x555
    lui a6, 0x33333
    ori a6, a6, 0x333
    lui a7, 0x0f0f0
    ori a7, a7, 0x788
    addi a7, a7, 0x787

    # OR the input value with itself shifted to the right by 1, 2, 4, 8, 16, and 16 bits (total 32).
    srli a1, a0, 1   
    or a0, a0, a1 
    srli a1, a0, 2   
    or a0, a0, a1 
    srli a1, a0, 4   
    or a0, a0, a1 
    srli a1, a0, 8   
    or a0, a0, a1 
    srli a1, a0, 16  
    or a0, a0, a1 
    srli a1, a0, 16  
    srli a2, a1, 16  
    or a0, a0, a2 
  
    # Count ones (population count).
    srli a1, a0, 1
    and a4, a1, a5  
    sub a0, a0, a4
    and a1, a0, a6
    srli a2, a0, 2
    and a3, a6, a2
    add a0, a3, a1
    srli a1, a0, 4
    add a0, a1, a0
    and a0, a0, a7
    srli a1, a0, 8
    add a0,a1,a0
    srli a1, a0, 16
    add a0, a1, a0
    srli a1, a0, 16
    srli a2, a1, 16
    add a0, a0, a2
  
    # Return the number of zeros.
    andi a0, a0, 0x7f # andi a0, a0, 0x7f
    addi a1, x0, input_size
    sub a0, a1, a0
    
    #count the priority
    addi a1, a1, -1
    sub a0, a1, a0
  
print:
    li a7, 35
    ecall
    lw a0, nextline
    li, a7, 11
    ecall
    bne s1, s0, loop
    beq s1, s0, end
    
end:  
    li a7, 10    # Exit system call
    ecall

