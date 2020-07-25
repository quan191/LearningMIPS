.text
addi $s0, $0, 2
addi $s1, $zero, 0 

loop:
li $v0 ,1
beq $s2, 16, exit
sllv $s2, $s0, $s1
addi $s1,$s1,1
move $a0, $s2
syscall
j loop

exit: