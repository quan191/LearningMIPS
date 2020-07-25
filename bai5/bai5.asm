.data
input: 	.space 50		# destination string result, empty
Message:	.asciiz "Input string more than 20 characters"
output: .space 50
.text
		la $a1,input		#load address of x to $a0
strcpy:
		add $s0,$zero,$zero 	# $s0 = i = 0
loop:
		li $v0, 12		#load value of input character in $v0
 		syscall
		add $t3,$s0,$a1		# $t3 = $s0 + $a0 = i + result[0]
 					# = address of result[i]
		sb $v0,0($t3) 		# result[i]= $t3 = $v0
		beq $v0,10,end_of_strcpy # if v0 == '\n' then break
		sgt $t1,$s0,20		#if i = $s0 > 20 then break
		beq $t1,1,end_of_strcpy
		nop
		addi $s0,$s0,1		# $s0 = $s0 + 1 <-> i = i + 1
		j loop 			# next character
		nop
end_of_strcpy:
		sgt $t1,$s0,20		#if i > 20 then exit
		beq $t1,1,error
		sgt $t1,$s0,$0		#if i < 20 then print string in reverse
		beq $t1,1,print_reverse
print_reverse:
	la $a2,output
	add $t6,$zero,0
		reverse:
			subi $s0,$s0,1		#$s0 = $s0 -1 <-> i = i - 1
			add $t3,$s0,$a1		# $t3 = $a0 + $s0 = result[0] + 1
			lb $t2,0($t3)
			add $t5,$t6,$a2
			sb $t2,0($t5)
			add $t6,$t6,1
 			beq $s0,$zero,exit	#if i =0 then exit
 			j reverse
error:
		li $v0, 4		#show error message
 		la $a0, Message
 		syscall
 		j exit
 exit:	
 		li $v0, 55		#service 59 is to show MessageDialogString
 		la $a0, output
 		la $a1,1
 		syscall

