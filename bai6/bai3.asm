.data 
A: .Word 7, 2, 5,10,12
Aend: .word
.text 
main: 
	la $a0, A  # $a0 is addresh of the first element of array
	la $a1, Aend # $a1 is adddresss of the last element of array
	add $t9,$a1,-4
	j loop
after_sort:
	li $v0, 10 
	syscall 
end_main:

check : 
	beq $t0,$t9,after_sort
	add $t0,$t0,4
	j loopi
loop:
	addi $t0, $a0,0  # $t0 is i run from 0 to n-2
loopi: 
	
	addi $t1,$t0,0   #$t1 is j run from i+1 to n-1
	
loopj: 
	addi $t1, $t1,4 
	lw $t3,0($t1) 
	lw $t4,0($t0) 
	slt $t5, $t4,$t3 
	bne $t5, $zero, swap 
	beq $t1,$a1,check
	j loopj
swap:
	sw $t3,0($t0) 
	sw $t4,0($t1) 
	beq $t1,$a1,check
	j loopj