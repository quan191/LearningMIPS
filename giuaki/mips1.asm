# Mid Term Project 10
#De bai : nguoi dung nhap 1 so x vao , chuong trinh se tinh toan 2^x , x^2 va chuyen doi tu x sang hexa 
.data
	message:		.asciiz			"Enter an integer"
	table:		.asciiz				"i	Power(2, i)	Square(i)	DecimalToHexa(i)\n"
	space1:		.asciiz				"	"
	space2:		.asciiz				"		"
	newLine:		.asciiz			"\n"
	errMessage1: 	.asciiz				"the input must be integer\n"
	errMessage2: 	.asciiz				"the input must not be null\n"
	errMessage3: 	.asciiz				"the input must greater than -31 , less than 30"
	afterErr:	.asciiz				"please re-input an integer\n"
	hex:			.space		10
.text
	li		$v0, 4					# print table header
	la		$a0, table
	syscall 
#above to print i	Power(2, i)	Square(i)	DecimalToHexa(i)
main:
	li		$v0, 51
	la		$a0, message
	syscall

	beq		$a1, -1,showErrorMessage1		# $a1 status value (neu so nhap vao k phai so nguyen => showErr)
	beq		$a1, -3,showErrorMessage2		# $a1 status value (neu khong nhap vao so nao ma ban ok => showErr)
	beq		$a1, -2,exit				# khi click cancel thi $a1=-2 => thoat truong trinh
	
	blt		$a0, -31, showErrorMessage3		# neu i < -31 thi nhap lai 
	bgt		$a0, 30, showErrorMessage3		# neu i > 30 thi nhap lai  ( vi thanh ghi trong mips co gia tri tu 2^-31 den 2^31-1)
	add		$s0, $zero, $a0				# gan $s0 = i 
	
	jal		power					# goi den function power(2, i)
	add		$s1, $zero, $s7				#ket qua tra ve cua function power la $s7 , luu vao $s1
	
	jal		square					# goi den function square(i)
	add		$s2, $zero, $s7				#ket qua tra ve cua function square la $s7 , luu vao $s2

	jal		decimalToHexa				# goi ham function decimalToHexa(i)
	j		printInput				# function decimalToHexa luu vao trong hex , nen gio chi can in ra
printInput:							#in gia tri cua i o hang moi
	li		$v0, 1					
	add		$a0, $zero, $s0
	syscall
	li		$v0, 4
	la		$a0, space1
	syscall
checkPowerResult:						#check gia tri cua i , neu i<0 thi dung printFloat , nguoc lai printInt
	blt 		$s0, $zero, printFloat

printInt	:	
	li		$v0, 1					# in gia tri power(2, i)
	add		$a0, $zero, $s1
	syscall
	li		$v0, 4
	la		$a0, space2
	syscall
	j		printSquare	
	
printFloat:							#in gia tri power(2,i)when i<0
	li		$v0, 2					# print float power(2, i)
	syscall							#vi i<0 nen 2^i se la 1/2^(-i)
	li		$v0, 4
	la		$a0, space2
	syscall
printSquare:
	li		$v0, 1					#in binh phuong cua i 
	add		$a0, $zero, $s2
	syscall	
	li		$v0, 4
	la		$a0, space2
	syscall
	
printHex:
	li		$v0, 4					# in xau hex sau khi chay ham  decimalToHexa(i)
	la		$a0, hex					
	syscall
	li		$v0, 4
	la		$a0, newLine
	syscall
	jal		clearHex
	
	j		main
	
exit:
	li		$v0, 10
	syscall
	
#--------------------------------------------------------------------
# function power
# param[in]		$s0		User entered integer i
# return1		$s7		i >= 0 power(2, i)
# return2		$f12		i < 0 power(2, i)
# return1 if i>=0 | return2
#--------------------------------------------------------------------
power:
	add		$s7,$zero,1				# gia tri khoi diem cua $s7=1
	li		$a0, 0					# $a0 = 0 =x 
	add		$a1, $zero, $s0			        # $a1 = $s0	
	bge		$s0, $zero, powerLoop		        # $s0 >= 0
	sub		$a1, $zero, $s0			        # $a1 = -$s0
	powerLoop:
		beq		$a0, $a1, powerDone		        # for (int x=0;x<i;x++)
		sll		$s7, $s7, 1				# $s7 = $s7 * 2
		addi		$a0, $a0, 1				# 
		j		powerLoop
	powerDone:
		bge		$s0, $zero, done			# neu x = $s0>0 thi ket thuc ham 
		li		$t0, 1					# neu x<0 thi thuc hien ham ben duoi chuyen tu int sang float roi float=float/float
		mtc1		$t0, $f0				# $f0 = 1.0
		cvt.s.w		$f0, $f0
	
		mtc1		$s7, $f2				# $f2 = (float)$s7
		cvt.s.w		$f2, $f2
		div.s		$f12, $f0, $f2				#$f12 = $f0/$f2
	done:	
		jr		$ra
#--------------------------------------------------------------------
# function square
# User entered integer i
# return		$s7		square(i)=i*i
#--------------------------------------------------------------------
square:
	mul		$s7, $s0, $s0			# $s7 = i * i
	jr		$ra
	
	
#--------------------------------------------------------------------
# function decimalToHexa
# User entered integer i
# return		none
# after this function , hex will store the Hexa after change
#--------------------------------------------------------------------
decimalToHexa:
	la		$a0, hex				# luu dia chi cua hex vao $a0
	add		$a1, $zero, $s0				# $a1 = i
	
	li		$t1, 48					# them 0x vao hex 
	sb		$t1, 0($a0)				# ma ASCII cua 0 là 48
	addi		$a0, $a0, 1				#
	li		$t1, 120				# ma ascii cua x la 120
	sb		$t1, 0($a0)				#
	addi		$a0, $a0, 1				#
	
	beqz		$s0, hexZero				# $s0 = 0 => hex = "0x0"
	
	li		$t0, 8					#vi moi thanh ghi trong mips co dang 0x00000000
	li		$t2, 0					# $t2 = 0 , de gan nhan , neu chua luu 1 ki tu khac 0 vao hex thi se k luu 0 vao hex
	
	hexLoop:
		beqz		$t0, hexDone				# counter == 0 => ket thuc ham 
		andi		$t1, $a1, 0xf0000000			# de lay phan du cho 16 thi ta co the dung toan tu and 
		srl		$t1, $t1, 28				# move 4 bits to most right
		beq		$t1, $t2, continue			# $t1 == $t2 (= 0) => khong cho vao hex , tiep tuc lam
		ble		$t1, 9, numberChangeString		# neu $t1 khac 0 : neu $t1<9 thi cong 48 nguoc lai cong 55
		addi		$t1, $t1, 55				# get [A-F] if $t1=10 , then plus 55 to get A
		j		writeHex
	
	numberChangeString:	
		addi		$t1, $t1, 48				# [1-9]
	
	writeHex:	
		addi		$t2, $t2, -1				# xoa nhan bo dau 0 , sau khi chay ham ben tren ma ra ket qua 1 ki tu khac 0 
		sb		$t1, 0($a0)				# viet ki tu vua tim duoc vao hex
		addi		$a0, $a0, 1
	
	continue:	
		sll		$a1, $a1, 4				# thanh ghi $a1 dich trai 4 bit
		addi		$t0, $t0, -1				# counter -= 1
		j		hexLoop
		
	hexZero:
		li		$t1, 48					# them ki tu  0 vao hex string
		sb		$t1, 0($a0)				
	
	hexDone:
		jr		$ra

#--------------------------------------------------------------------
# function clearHex
# return		none
# after clearHex , Hex will be null
#--------------------------------------------------------------------
clearHex:
	la		$a0, hex					# load hex to $a0
	li		$a1, 0
	clearLoop:
		beq		$a1, 10, doneClear
		sb		$zero, 0($a0)				
		addi		$a0, $a0, 1
		addi		$a1, $a1, 1
		j		clearLoop
	doneClear:
		jr		$ra	

#--------------------------------------------------------------------
# @function show Error message
# @return		none
#--------------------------------------------------------------------
showErrorMessage1:
	li 		$v0,59
	la 		$a0,errMessage1
	la 		$a1,afterErr
	syscall
	j		main
showErrorMessage2:
	li 		$v0,59
	la 		$a0,errMessage2
	la 		$a1,afterErr
	syscall
	j		main
	
showErrorMessage3:
	li 		$v0,59
	la 		$a0,errMessage3
	la 		$a1,afterErr
	syscall
	j		main




