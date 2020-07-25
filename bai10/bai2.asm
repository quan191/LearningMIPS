.eqv MONITOR_SCREEN 0x10010000 #Dia chi bat dau cua bo nho man hinh
.eqv RED 0x00FF0000 #Cac gia tri mau thuong su dung
.eqv GREEN 0x0000FF00
.eqv BLUE 0x000000FF
.eqv WHITE 0x00FFFFFF
.eqv YELLOW 0x00FFFF00
.text
 li $k0, MONITOR_SCREEN #Nap dia chi bat dau cua man hinh

 li $t0, YELLOW
 sw $t0, 0($k0)
 nop
 li $t0, YELLOW
 sw $t0, 32($k0)
 nop
 li $t0, YELLOW
 sw $t0, 64($k0)
 nop
 li $t0, YELLOW
 sw $t0, 96($k0)
 nop
 li $t0, YELLOW
 sw $t0, 128($k0)
 nop
  li $t0, YELLOW
 sw $t0, 160($k0)
 nop
  li $t0, YELLOW
 sw $t0, 192($k0)
 nop
  li $t0, YELLOW
 sw $t0, 224($k0)
 nop
   li $t0, RED
 sw $t0, 20($k0)
 nop
    li $t0, RED
 sw $t0, 16($k0)
 nop
    li $t0, RED
 sw $t0, 24($k0)
 nop
    li $t0, RED
 sw $t0, 28($k0)
 nop
    li $t0, RED
 sw $t0, 48($k0)
 nop
    li $t0, RED
 sw $t0, 80($k0)
 nop
    li $t0, RED
 sw $t0, 112($k0)
 nop
    li $t0, RED
 sw $t0, 116($k0)
 nop
    li $t0, RED
 sw $t0, 120($k0)
 nop
    li $t0, RED
 sw $t0, 124($k0)
 nop
    li $t0, RED
 sw $t0, 156($k0)
 nop
    li $t0, RED
 sw $t0, 188($k0)
 nop
    li $t0, RED
 sw $t0, 220($k0)
 nop
    li $t0, RED
 sw $t0, 256($k0)
 nop
    li $t0, RED
 sw $t0, 252($k0)
 nop
    li $t0, RED
 sw $t0, 248($k0)
 nop
    li $t0, RED
 sw $t0, 244($k0)
 nop
    li $t0, RED
 sw $t0, 240($k0)
 nop
 