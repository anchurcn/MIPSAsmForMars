.data
arr:.word 0:10
sise:.word 10
temp:.word 0
str:.asciiz "helloworld\n"
# macro define
.macro printStr(%str)# %str is a pointer to string
	lw $a0, %str
 	li $v0, 4
 	syscall
 .end_macro
 .macro print(%str)
 	la $a0, %str
 	li $v0, 4
 	syscall
 .end_macro 
 .macro printInta0
 	li $v0,1
 	syscall
 .end_macro
 .macro exit
 	li $v0,10
 	syscall
 .end_macro
.text
main:
	move $t1,$a0		# $t0=size
	li $t0,0		# $ti=i=0
	la $t3,arr		# $t3 point to arr element
for:
	blt $t0,$t1,forcode
	j forend
forcode:
	lw $t2,($a1)		# load content
	sw $t2,temp
	#printStr(temp)
	#print(str)		# print space
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
	exit
	printInta0
 	lw $a0, 0($a1)	# Get first argument from command line and save to $t0
 	#la $a0, 0($t0)
 	li $v0, 4	# Syscall to print the value in $t0
 	syscall
