#------------------------------------------------------
#FINAL PROJECT 
#WRITE A PROGRAM TO READ KEY PRESS FROM DIGITAL LAB SIM ( 0 , 4 , 8 ) AND THEN RUN THE POSTSCRIPT TO MAKE MARSBOT RUN 
# POSTSCRIPT EXAMPLE : 40,5000,1 . 40 TO GIVE THE ANGLE ROTATE OF MARSBOT , 5000 IS SLEEPING TIME , 1 TO TRACK OR UNTRACK ( 1=TRACK, 0=UNTRACK)
#WHEN PRESS 0 , MARSBOT RUN POSTSCRIPT 1 
#WHEN PRESS 4, MARSBOT RUN POSTSCRIPT 2 
#WHEN PRESS 8 , MARSBOT RUN POSTSCRIPT 3 
#------------------------------------------------------
#------------------------------------------------------
 #           col 0x1    col 0x2    col 0x4     col 0x8  
 # #  row 0x1      0         1          2           3           
  #             0x11      0x21        0x41        0x81          
  # #  row 0x2      4         5          6           7 
  #             0x12      0x22        0x42        0x82 
  # #  row 0x4      8         9          a           b  
  #             0x14      0x24        0x44        0x84 
  # #  row 0x8      c         d          e           f 
  #             0x18      0x28        0x48        0x88 
  # #------------------------------------------------------  
  #key input digital lab sim
 .eqv IN_ADRESS_HEXA_KEYBOARD       0xFFFF0012 
 .eqv OUT_ADRESS_HEXA_KEYBOARD      0xFFFF0014
 # mars bot 
 .eqv HEADING 0xffff8010 
.eqv MOVING 0xffff8050
.eqv LEAVETRACK 0xffff8020
.eqv WHEREX 0xffff8030
.eqv WHEREY 0xffff8040
#POSTSCRIPT MARS BOT 
.data
#postscript 1 : DCE , 0 key press in digital lab sim 
postscript1: .asciiz "90,2000,0;180,3000,0;180,5790,1;80,500,1;70,500,1;60,500,1;50,500,1;40,500,1;30,500,1;20,500,1;10,500,1;0,500,1;350,500,1;340,500,1;330,500,1;320,500,1;310,500,1;300,500,1;290,500,1;280,490,1;90,7000,0;270,500,1;260,500,1;250,500,1;240,500,1;230,500,1;220,500,1;210,500,1;200,500,1;190,500,1;180,500,1;170,500,1;160,500,1;150,500,1;140,500,1;130,500,1;120,500,1;110,500,1;100,500,1;90,1000,1;90,5000,0;270,2000,1;0,5800,1;90,2000,1;180,2900,0;270,2000,1;90,3000,0;"
#postScript 2 : box , key 4 press in data lab sim 
postscript2: .asciiz "90,4000,0;180,4000,0;50,5000,1;90,7000,1;230,5000,1;270,7000,1;180,7000,1;90,7000,1;0,6990,1; 210,5000,0;180,7000,1;230,5000,1;270,7000,0;50,500,1;50,500,0;50,500,1;50,500,0;50,500,1;50,500,0;50,500,1;50,500,0;50,500,1;50,500,0;0,500,1;0,500,0;0,500,1;0,500,0;0,500,1;0,500,0;0,500,1;0,500,0;0,500,1;0,500,0;0,500,1;0,500,0;0,500,1;0,500,0;180,7000,0;90,500,1;90,500,0;90,500,1;90,500,0;90,500,1;90,500,0;90,500,1;90,500,0;90,500,1;90,500,0;90,500,1;90,500,0;90,500,1;90,500,0;"
#postScript3 :  heart , key 8 press in data lab sim 
postscript3: .asciiz "90,14000,0;180,7000,0;30,100,1;35,100,1;40,100,1;45,100,1;50,100,1;55,100,1;60,100,1;65,100,1;70,100,1;75,100,1;80,100,1;85,100,1;90,100,1;105,100,1;110,100,1;115,100,1;120,100,1;125,100,1;130,100,1;135,100,1;140,100,1;145,100,1;150,100,1;155,100,1;160,100,1;165,100,1;170,100,1;175,100,1;180,100,1;195,200,1;200,200,1;205,200,1;210,200,1;215,200,1;220,200,1;225,200,1;230,200,1;235,400,1;240,400,1;230,400,1;220,200,1;215,100,1;325,100,1;320,200,1;310,400,1;300,400,1;305,400,1;310,200,1;315,200,1;320,200,1;325,200,1;330,200,1;335,200,1;340,200,1;345,200,1;0,100,1;5,100,1;10,100,1;15,100,1;20,100,1;25,100,1;30,100,1;35,100,1;40,100,1;45,100,1;50,100,1;55,100,1;60,100,1;65,100,1;70,100,1;75,100,1;90,100,1;95,100,1;100,100,1;105,100,1;110,100,1;115,100,1;120,100,1;125,100,1;130,100,1;135,100,1;140,100,1;145,100,1;150,100,1;180,5000,0;270,3000,0;45,3000,1;45,2000,0;45,2000,1;"	
.text 
main:
	
	jal HANDLEKEYPRESS
	jal GO
	jal HANDLE_POSTSCRIPT
	j END
 # #------------------------------------------------------ 
 # Function to read the key press in Digital Lab sim 
 # if press 0 => run postScript 1 
 # if press 4 => run postScript 2 
 #if press  8 => run postScript 3 
 # #------------------------------------------------------ 
HANDLEKEYPRESS:            
	li    $t1,   IN_ADRESS_HEXA_KEYBOARD                  
	li    $t2,   OUT_ADRESS_HEXA_KEYBOARD                      
	polling: 
		if_num_0:        
			li $t3, 0x01 		# row-1 of key matrix
			sb $t3, 0($t1) 
			lb $a0, 0($t2) 
			bne $a0, 0x11, if_num_4
			la $a1, postscript1
			jr $ra
		if_num_4:
			li $t3, 0x02 		# row-2 of key matrix
			sb $t3, 0($t1)
			lb $a0, 0($t2)
			bne $a0, 0x12, if_num_8
			la $a1, postscript2
			jr $ra
		if_num_8:
			li $t3, 0X04		 # row-3 of key matrix
			sb $t3, 0($t1)
			lb $a0, 0($t2)
			bne $a0, 0x14, back_to_polling
			la $a1, postscript3
			jr $ra       
	back_to_polling: j     polling          # continue polling if key press not 0 , 4 ,8 
 # #------------------------------------------------------ 
 # Function to read the postScript and handle data
 # #------------------------------------------------------ 
 HANDLE_POSTSCRIPT:
 	addi $sp,$sp,-4 
 	sw $ra , 0($sp)
 	read_post:
 		addi $t1, $zero, 0 		# $t1 to store angle rotate
		addi $t2, $zero, 0 		# $t2 to store time bot running 
		addi $t3, $zero, 0		# $t3 to check track or untrack , 1 to track , 0 to untrack
		li $t7,0			#$t7 to store string to integer 
		
#  read angle rotate :
		read_rotate :
			add $t5, $a1, $t4		#$t5 is address of a[i]
			lb $t6, 0($t5)  		# $t6= a[i]
			beq $t6, 0, end_handle_psc 	# if $t6==null , end
 			beq $t6, 44, end_read_rotate 	# if $t6=44="," , end read rotate , begin read time travel
 			jal STRING_TO_INTEGER
 			addi $t4, $t4, 1 		# i=i+1
 			j read_rotate 		
# read time running :
	end_read_rotate:
		add $t1,$t7,$zero
		li $t7,0
		
		read_time_run:
			addi $t4, $t4, 1 		# i=i+1 to not read ","
			# read time run 
			add $t5, $a1, $t4		#$t5 is address of a[i]
			lb $t6, 0($t5)  		# $t6= a[i]
 			beq $t6, 44, end_read_time 	# if $t6=44="," , end read time , begin read track
 			jal STRING_TO_INTEGER
 			j read_time_run
# read track or not :
	end_read_time:
		add $t2,$t7,$zero
		li $t7,0
		
		read_track_untrack:
			addi $t4, $t4, 1 	# i=i+1 to not read ","
			add $t5, $a1, $t4		#$t5 is address of a[i]
			lb $t6, 0($t5)  	# $t6= a[i]
			jal STRING_TO_INTEGER
			add $t3,$zero,$t7
			beq $t3,0,draw_untrack # $t6 = 48 = "0" then marsbot run without leave track
			j draw_track
draw_track:
	jal TRACK
	nop
	add    $a0, $zero, $t1  # Marsbot rotates 90* and start 
	jal     ROTATE         
        addi $v0,$zero,32 	# Keep mars bot running by sleeping with time=$t2
 	add $a0, $zero, $t2
 	syscall
        jal     UNTRACK         # keep old track        
        nop       
        addi $t4, $t4, 2 			# bo qua dau ';'
 	j	read_post
draw_untrack:	
	jal UNTRACK
	nop
	add    $a0, $zero, $t1  # Marsbot rotates 90* and start 
	jal     ROTATE         
       	nop          
       
	addi $v0,$zero,32 	# Keep mars bot running by sleeping with time=$t2
 	add $a0, $zero, $t2
 	syscall
        jal     UNTRACK         # keep old track         
        nop     
	addi $t4, $t4, 2 			# bo qua dau ';'
 	j read_post

 end_handle_psc:
 	lw $ra , 0($sp)
 	addi $sp,$sp,4
 	jr $ra
##------------------------------------------------------ 
#funtion to turn String to integer :
##------------------------------------------------------ 
STRING_TO_INTEGER:
	mul $t7, $t7, 10 
 	addi $t6, $t6, -48 	
 	add $t7, $t7, $t6  		# $t0=$t0*10+$t6
	jr $ra
#----------------------------------------------------------- 
# GO procedure, to start running 
# param[in]    none 
#----------------------------------------------------------- 
GO:     
	li    $at, MOVING     # change MOVING port         
	addi  $k0, $zero,1    # to  logic 1,         
	sb    $k0, 0($at)     # to start running         
	nop                 
	jr    $ra         
	nop 
#----------------------------------------------------------- 
# STOP procedure, to stop running 
# param[in]    none 
#----------------------------------------------------------- 
STOP:   
	li    $at, MOVING     # change MOVING port to 0         
	sb    $zero, 0($at)   # to stop         
	nop         
	jr    $ra         
	nop 
#----------------------------------------------------------- 
# TRACK procedure, to start drawing line  
# param[in]    none 
#-----------------------------------------------------------              
TRACK:  
	li    $at, LEAVETRACK # change LEAVETRACK port         
	addi  $k0, $zero,1    # to  logic 1,         
	sb    $k0, 0($at)     # to start tracking         
	nop         
	jr    $ra         
	nop         
#----------------------------------------------------------- 
# UNTRACK procedure, to stop drawing line 
# param[in]    none 
#-----------------------------------------------------------         
UNTRACK:
	li    $at, LEAVETRACK # change LEAVETRACK port to 0         
	sb    $zero, 0($at)   # to stop drawing tail        
	 nop         
	 jr    $ra        
	  nop
#----------------------------------------------------------- 
# ROTATE procedure, to rotate the robot 
# param[in]    $a0, An angle between 0 and 359
 #                   0 : North (up) #                   90: East  (right) #                  180: South (down) #                  270: West  (left) 
 #-----------------------------------------------------------  
 ROTATE: 
 	li    $at, HEADING    # change HEADING port         
 	sw    $a0, 0($at)     # to rotate robot         
 	nop         
 	jr    $ra         
 	nop   
END:
	jal STOP
	
		
