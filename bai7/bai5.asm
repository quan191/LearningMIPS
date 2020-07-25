.data
Message1:	.asciiz "The largest element is stored in $s"
Message2:	.asciiz " ,largest value is "
Message3:	.asciiz "\nThe smallest element is stored in $s"
Message4:	.asciiz " ,smallest value is "
.text
main:
	li $s0,10
	li $s1,20
	li $s2,10
	li $s3,15
	li $s4,12
	li $s5,6
	li $s6,27
	li $s7,26
	jal beforeLoop
	li $v0,4
	la $a0,Message1
	syscall
	li $v0,1
	add $a0,$t8,$0
	syscall
	li $v0,4
	la $a0,Message2
	syscall
	li $v0,1
	add $a0,$t1,$0
	syscall
	li $v0,4
	la $a0,Message3
	syscall
	li $v0,1
	add $a0,$t9,$0
	syscall
	li $v0,4
	la $a0,Message4
	syscall
	li $v0,1
	add $a0,$t2,$0
	syscall
end_main:
	li $v0,10
	syscall
Max:
	add $t1,$t3,$0		#update max value
	add $t8,$t0,$0		#update index of max value
	jr $ra
Min:
	add $t2,$t3,$0		#update min value
	add $t9,$t0,$0		#update index of min value
	jr $ra
beforeLoop:	
	add $fp,$sp,$0		#frame pointer point to the top
	addi $sp,$sp,-32	#allocate space for stack
	sw $s1,0($sp)
	sw $s2,4($sp)
	sw $s3,8($sp)
	sw $s4,12($sp)
	sw $s5,16($sp)
	sw $s6,20($sp)
	sw $s7,24($sp)
	sw $ra,28($sp)         	#save return address
	li $t0,0		#current index
	add $t1,$s0,$0		#set min value = $s0
	add $t2,$s0,0		#set max value = $s0
	li $t8,0		#$t8 to store index of max  value
	li $t9,0		#$t9 to store index of	min  value
loopMinMax:
	addi $sp, $sp,4		#adjust stack pointer
	lw $t3,0($sp)		#load current value to $t3
	beq $t0,6,done		#if do 7 loop means u check all the 8 element 
	addi $t0,$t0,1		#adjust index
	sub $t4,$t1,$t3		#check if t3 > max value
	bltzal $t4,Max		#if true, update max value
	sub $t4,$t3,$t2 	#check if t3 < min value
	bltzal $t4,Min		#if true, update min value
	j loopMinMax
done:
	lw $ra,0($sp)
	jr $ra
