.text
addi $s1, $zero, -8
	abs: #abs $s0, $s1;
	bltz $s1, negative
	add $s0, $0, $s1
	j EXIT
	negative:
	subi $s1, $s1, 1
	nor $s1, $s1, $0
	add $s0, $s1, $0
	EXIT:
addi $s1, $zero, 8	
	move: #move $s0 and  $s1
	xor $s0, $s0, $s1
	xor $s1, $s0, $s1
	xor $s0,  $s0, $s1
addi $s1, $zero, 8
	not: # not $s0
	nor $s0, $s0, $0

addi $s1, $zero, 8
addi $s2, $zero, 3

	ble: #branch less and equal
	slt $t0, $s2, $s1
	beq $t0, $0, false
	addi $t1, $0, 1
	j exit
	false:
	addi $t1, $0, 0
	exit:
