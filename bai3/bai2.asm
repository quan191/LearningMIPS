#Laboratory 3, Home Assigment 2 
.data
arr: .word 4, 5, 6 

.text 
add $s1,$zero,-1 #i=-1
add $s4,$zero,1   #step
add $s3,$zero,2   #n=2
la $s2,arr   #
loop: add  $s1,$s1,$s4  #i=i+step  
add  $t1,$s1,$s1  #t1=2*s1  
add $t1,$t1,$t1  #t1=4*s1   
add $t1,$t1,$s2  #t1 store the address of A[i]  
lw $t0,0($t1)  #load value of A[i] in $t0  
add $s5,$s5,$t0  #sum=sum+A[i]  
bne $s1,$s3,loop #if i != n, goto loop
