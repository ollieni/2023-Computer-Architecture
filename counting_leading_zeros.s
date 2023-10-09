.data:
    newline: .string "\n"
    
count_leading_zeros:
  # Load the constants A01, A02, and mask 0x0f0f0f0f
  addi a0, x0 ,33
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
  
   
   
   

  # Return the number of leading zeros.
  andi a0, a0, 0x7f # andi a0, a0, 0x7f
  addi a1, x0, 64
  sub a0, a1, a0
print:
  li a7,1
  ecall
  lw a0, newline
  li, a7, 11
  ecall









