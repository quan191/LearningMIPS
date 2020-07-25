.eqv KEY_CODE 0xFFFF0004 		# ASCII code from keyboard, 1 byte
.eqv KEY_READY 0xFFFF0000 		# =1 if has a new keycode ?
 					# Auto clear after lw
.eqv DISPLAY_CODE 0xFFFF000C 		# ASCII code to show, 1 byte
.eqv DISPLAY_READY 0xFFFF0008 		# =1 if the display has already to do
 					# Auto clear after sw
.text
	li $k0, KEY_CODE
	li $k1, KEY_READY
	
	li $s0, DISPLAY_CODE
	li $s1, DISPLAY_READY

WaitForE:
	jal WaitForKey			# get entered key in $t0
	
	beq $t0, 0x65, WaitForX		# 0x65 is 'e' ASCII, bracnh WaitForX if enter 'e'
	b WaitForE			# branch WaitForE otherwise

WaitForX:
	jal WaitForKey
	
	beq $t0, 0x78, WaitForI		# 0x78 is 'x' ASCII, bracnh WaitForX if enter 'x'
	b WaitForE			# branch WaitForE otherwise
	
WaitForI:
	jal WaitForKey			# get entered key in $t0
	
	beq $t0, 0x69, WaitForT		# 0x69 is 'i' ASCII, bracnh WaitForT if enter 'i'
	beq $t0, 0x8, WaitForX		# 0x8 is backspace ASCII, bracnh WaitForX if press backspace
	b WaitForE			# branch WaitForE otherwise
	
WaitForT:
	jal WaitForKey			# get entered key in $t0
	
	beq $t0, 0x74, exit		# 0x74 is 't' ASCII, exit if enter 't'
	beq $t0, 0x8, WaitForI		# 0x8 is backspace ASCII, bracnh WaitForI if press backspace
	b WaitForE		# branch WaitForE otherwise
#-----------------------------------------------------	
# Read input key, store input key in $t0
#-----------------------------------------------------
WaitForKey: 
		lw $t1, 0($k1) 			# $t1 = [$k1] = KEY_READY
		nop
		beq $t1, $zero, WaitForKey 	# if $t1 == 0 then Polling
		nop
 #-----------------------------------------------------
	ReadKey: 
		lw $t0, 0($k0) 			# $t0 = [$k0] = KEY_CODE
		nop
	jr $ra	
 #-----------------------------------------------------
WaitForDis: lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY
 nop
  beq $t2, $zero, WaitForDis # if $t2 == 0 then Polling
 nop
 #-----------------------------------------------------
Encrypt: addi $t7, $t0, 1 # change input key
 #-----------------------------------------------------
ShowKey: sw $t7, 0($s0) # show key
 nop
 #-----------------------------------------------------

 nop	
exit: 
	li $v0, 10
	syscall
	


	
