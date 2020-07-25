.data 
A: .word 1,10,2,31,12
Aend: .word 
.text 
main: 
	la $a0, A 
	la $a1, Aend 
	addi $a2, $a0, 4 
	j sort 
after_sort:	
	li $v0, 10 
	syscall 

end_main: 
sort: 
 	beq $a2, $a1, done
 	j loop 
after_loop: 	
 	addi $a2,$a2,4 
 	j sort 
done: 	j after_sort

loop: 
	addi $t0, $a2,-4 
	lw $t1, 0($a2)

condition:
	slt $t2,$t0,$a0
	bne $t2,$0,ret
condition2:
	lw $t3,0($t0) 
	slt $t2,$t1,$t3
	beq $t2, $0,ret
	sw $t3,4($t0) 
	addi $t0,$t0,-4
	j condition 
ret: 
	sw $t1,4($t0) 
	j after_loop
	