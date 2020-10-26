.data
 numbers: .word 0:100			#create array which holds numbers
 size:.word 100
 temp:.word 0
 
 str_buf:.byte 0:32
 message: .asciiz "Sorted values:\n"		
 intmsg:.asciiz "Integer values:\n"
 argsmsg:.asciiz "Program arguments:\n"
 newLine:.asciiz "\n"
 space:.asciiz " "
 
 #macro define
 .macro printStr(%str)			# %str stores first char
 	la $a0, %str
 	li $v0, 4,
 	syscall
 .end_macro 
 .macro print(%str)			# %str is a pointer to string
	lw $a0, %str
 	li $v0, 4
 	syscall
 .end_macro
 .macro exit
 	li $v0,10
 	syscall
 .end_macro
 .macro clr_buf				# clear str_buf
 	li $t6,0
 	li $t7,8
 	la $t8,str_buf
 while1:
 	blt $t6,$t7,do1
 	j while_end1
 do1:
 	sw $zero,0($t8)
 	addi $t6,$t6,1
 	addi $t8,$t8,4
 	j while1
 while_end1:
 .end_macro
 
 .text
 main:				#parse args to integers; store in numbers
	move $t1,$a0		# $t1=size
	sw $t1,size
	li $t0,0		# $t0=i=0 as loop variable
	la $t3,numbers		# $t3 points to array element
	printStr(argsmsg)
for:				#loop
	blt $t0,$t1,forcode
	j forend
forcode:
	lw $t2,($a1)		# load content
	sw $t2,temp
	print(temp)
	move $t9,$t1		# no space if $t0 equals $t1-1
	sub $t9,$t9,1
	beq $t0,$t9,endif1
	printStr(space)		# print space
endif1:
	#storeHexHere
	# $t3 as arrpos
	lw $t4,temp
	addi $t4,$t4,2		# $t4 is addr of byte[2]
	li $t8,0		# $t8 stores result
whileCondition:
	lb $t5,($t4)		# $t5 stores the char
	bne $t5,0,whileTrue
	j whileEnd
whileTrue:
	li $t6,0		# $t6 sotres subresult for every byte
	#if
	blt $t5,'A',else		# if byte less then 'A', jump else
	sub $t6,$t5,55
	j endif
	#else
else:
	sub $t6,$t5,'0'
endif:
	mul $t8,$t8,16		# $t6<<=4
	add $t8,$t8,$t6
	addi $t4,$t4,1		#move to next byte
	j whileCondition
whileEnd:
	sw $t8,($t3)		# save $t8 content to addr $t3
	addi $t3,$t3,4		# arr element move next
	#endStoreHex
	addi $t0,$t0,1
	addi $a1,$a1,4		# move the $a1 point to next
	j for
forend:
### print unsorted array
	printStr(newLine)
	printStr(newLine)
	printStr(intmsg)
	li $t3,0
 	lw $t4,size
 	la $s7,numbers
 print_unsorted:
 	beq $t3, $t4, print_unsorted_end				#if t3 = t4 go to final
 	lw $t5, 0($s7)					#load from numbers
 	li $v0, 1					#print the number
 	move $a0, $t5
 	syscall
 	move $t9,$t4
 	sub $t9,$t9,1
 	beq $t3,$t9,endif2
	printStr(space)
endif2:
 	addi $s7, $s7, 4				#increment through the numbers
 	addi $t3, $t3, 1				#increment counter
 	j print_unsorted
 print_unsorted_end:	
 ### insertion sort
sort_prep:
     la  $t0, numbers        	# load array to $t0.
     lw  $t1, size           	# load array size to $t1.
     li  $t2, 1              	# loop xloop iter(t2), starting from 1.
 sort_xloop:
     la  $t0, numbers          # load array to $t0.
     bge $t2, $t1, sort_xloop_end    # while (t2 < $t1).
     move    $t3, $t2        # copy $t2 to $t3.
     sort_iloop:
         ble $t3, $zero, sort_iloop_end  # while (t3 > 0).
         la  $t0, numbers      # load array to $t0.
         mul $t5, $t3, 4     
         add $t0, $t0, $t5   # calculate the array index, $t0 is calc from $t3
         lw  $t7, 0($t0)     # load array[$t3] to $t7.
         lw  $t6, -4($t0)    # load array[$t3 - 1] to $t6.
         bge $t7, $t6, sort_iloop_end   # if(array[$t3] > array[$t3 - 1]) then iter the iloop.
         lw  $t4, 0($t0)     # swaping the values
         sw  $t6, 0($t0)
         sw  $t4, -4($t0)
         addi $t3, $t3, -1   # decrement innerloop iter($t3) 
         j   sort_iloop      # jump back to the beginning of the sort_iloop.
     sort_iloop_end:
         addi $t2, $t2, 1    # increment loop runner by 1.
         j   sort_xloop      # jump back to the beginning of the sort_xloop.
 sort_xloop_end:
### print sorted array
	printStr(newLine)
	printStr(newLine)
	printStr(message)
	li $t3,0
 	lw $t4,size
 	la $s7,numbers
 printsorted:
 	beq $t3, $t4, final				#if t3 = t4 go to final
 	lw $t5, 0($s7)					#load from numbers
 	#li $v0, 1					#print the number
 	#move $a0, $t5
 	#syscall
 	clr_buf
 	move $a0,$t5
 	la $a1,str_buf
 	jal itoa
 	printStr(str_buf)
 	
 	move $t9,$t4
 	sub $t9,$t9,1
 	beq $t3,$t9,endif3
	printStr(space)
endif3:
 	addi $s7, $s7, 4				#increment through the numbers
 	addi $t3, $t3, 1				#increment counter
 	j printsorted
 final:	
 	printStr(newLine)
 	exit

## functions
 itoa:
 	sw $ra,($sp)
 	sub $sp,$sp,4
 	li $t6,10
 	move $s2, $a0
 	move $t1, $a1		
 	divLoop:
 	div $s2, $t6
 	mfhi $t8
 	mflo $s2
 	add $t8,$t8,48
 	sb $t8,($t1)
 	add $t1, $t1, 1
 	bne $s2, $zero, divLoop
 	move $t0,$a1
 	jal len
 	move $t0,$a1
 	move $t1,$a1
 	add $t1, $t1 , $t8
 	sub $t1, $t1,1
 	div $t8,$t8,2
 	li $t6,0 	#reset to 0
 	reverseLoop:
 	lb $t7,($t0)
 	lb $t2,($t1)
 	sb $t2,($t0)
 	sb $t7,($t1)
 	add $t6, $t6, 1
 	sub $t1, $t1, 1
 	add $t0, $t0, 1
 	blt $t6,$t8,reverseLoop
 	add $sp,$sp,4
 	lw $ra,($sp)
 	jr $ra

 len:
 	sw $ra,($sp)
 	sub $sp,$sp,4
 	li $t8,0
 	loop1:
 		lb $t7,($t0)
 		add $t0,$t0,1
 		beq $t7,' ',detect
 		add $t8,$t8,1			 		 
 	  condt:
 	  bne $t7,'\0',loop1 
 	  j end1
 	  detect:
 	  	j condt
 	  end1:
 	  sub $t8, $t8, 1
 	  add $sp,$sp,4
 	  lw $ra,($sp)
 	  jr $ra
