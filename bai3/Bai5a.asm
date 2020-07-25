.data
	i : .word -1
	n : .word 5
	step : .word 1
	A : .word 3:10
	sum : .word 0
.text
start:
	la $t1, i		#load address i into $t1
	lw $s1, 0($t1)		#load i into $s1
	la $s2, A		#load address A into $s2
	la $t1, n		#load address n into $t1
	lw $s3, 0($t1)		#load n into $s3
	la $t1, step		#load address step into $t1
	lw $s4, 0($t1)		#load step into $s4
	la $t1, sum		#load address sum into $t1
	lw $s5, 0($t1)		#load sum into $s5

loop: 
	add $s1,$s1,$s4 	#i=i+step
	add $t1,$s1,$s1 	#t1=2*s1
	add $t1,$t1,$t1 	#t1=4*s1
	add $t1,$t1,$s2 	#t1 store the address of A[i]
	lw $t0,0($t1) 		#load value of A[i] in $t0
	add $s5,$s5,$t0 	#sum=sum+A[i]
	slt $s7,$s1,$s3		#test i < n
	bne $s7,$zero,loop	#i < n true -> loop
	
	la $t1, sum
	sw $s5, 0($t1)		#save $s5 into sum
