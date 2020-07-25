.data
Message1:	.asciiz	"The sum of "
Message2: 	.asciiz " and "
Message3:	.asciiz " is "

.text
	li $s0,220		
	li $s1,10
	add $s2,$s1,$s0
	li $v0,4		#service 4 is print string
	la $a0,Message1		#load address of message1 to $a0
	syscall
	li $v0,1		#service 1 is print integer
	la $a0,0($s0)		#load address of $s0 to %$a0
	syscall	
	li $v0,4		#service 4 is print string
	la $a0,Message2		#load address of message2 to $a0
	syscall
	li $v0,1		#service 1 is print integer
	la $a0,0($s1)		#load address of $s1 to %$a0
	syscall
	li $v0,4		#service 4 is print string
	la $a0,Message3		#load address of message3 to $a0
	syscall
	li $v0,1		#service 1 is print integer
	la $a0,0($s2)		#load address of $s2 to %$a0
	syscall