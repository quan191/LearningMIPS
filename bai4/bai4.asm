.text
	addi $s1, $s1, 0xffffffff
	addi $s2, $s2, 0x80000000
	li $t0, 0
	addu $s3, $s1, $s2
	xor $t1, $s1, $s2
	bltz $t1, exit
	xor $t2, $s1, $s3
	bgez  $t2, exit
	li $t0, 1
	exit:
