.data
	i : .word 3
	j : .word 5
	x : .word 2
	y : .word 4
	z : .word 2
.text
start:
	la $t1, i		#load address i into $t1
	lw $s1, 0($t1)		#load i into $s1
	la $t1, j		#load address j into $t1
	lw $s2, 0($t1)		#load j into $s2
	la $t1, x		#load address x into $t1
	lw $s3, 0($t1)		#load x into $s3
	la $t1, y		#load address y into $t1
	lw $s4, 0($t1)		#load y into $s4
	la $t1, z		#load address z into $t1
	lw $s5, 0($t1)		#load z into $s5

	slt $t0,$s1,$s2		#test i<j , if true $t0=1 else $t1=0
	bne $t0,$zero,else	#i<j not true ->$t1=0 -> $t0 != $zero
	addi $s3,$s3,2		#x = i +2
	addi $s5,$zero,1	#z = 1
	j endif			#skip else
else: 
	addi $s4,$s4,2	#y = y + 2
	add $s5,$s5,0		#z = z 
endif:
	la $t1, x		
	sw $s3, 0($t1)		#save $t1 to x
	la $t1, y
	sw $s4, 0($t1)		#save $t2 to y
	la $t1, z		
	sw $s5, 0($t1)		#save $t3 to z
