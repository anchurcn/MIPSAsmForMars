.data
 newLine:	.asciiz "\n"
 printName:	.asciiz "name: "
 space:		.asciiz " "
 t:		.word 20
 y:		.word 20
 z:		.word 20
 enter:		.asciiz "enter value of "
 nameT:		.asciiz "t: "
 nameY:		.asciiz "y: "
 nameZ:		.asciiz "z: "
 for:		.asciiz "for: "
 formula1:	.asciiz "a = z - y + t;		  a = "
 formula2:	.asciiz "b = t - 4(8 + z) + y;     b = " 
 .text
 namePrinter:
 	li $v0, 4	# Syscall to print the value of printName
 	la $a0, printName
 	syscall
 	lw $t0, 0($a1)	# Get first argument from command line and save to $t0
 	lw $t1, 4($a1)	# Get second argument from command line and save to $t1
 	li $v0, 4	# Syscall to print the value in $t0
 	la $a0, ($t0)
 	syscall
 	li $v0, 4	# Syscall to print the value of space
 	la $a0, space
 	syscall
 	li $v0, 4	# Syscall to print the value in $t1
 	la $a0, ($t1)
 	syscall
 enterThreeValues:
 	li $v0, 4
 	la $a0, newLine
 	syscall
 	li $v0, 4	# Syscall to print the value of space
 	la $a0, enter
 	syscall
 	li $v0, 4	# Syscall to print the value of space
 	la $a0, nameT
 	syscall
 	li $v0, 5	# Enter integer
 	syscall
 	sw $v0, t
 	li $v0, 4
 	la $a0, newLine
 	syscall
 	li $v0, 4	# Syscall to print the value of space
 	la $a0, enter
 	syscall
 	li $v0, 4	# Syscall to print the value of space
 	la $a0, nameY
 	syscall
 	li $v0, 5	# Enter integer
 	syscall
 	sw $v0, y
 	li $v0, 4
 	la $a0, newLine
 	syscall
 	li $v0, 4	# Syscall to print the value of space
 	la $a0, enter
 	syscall
 	li $v0, 4	# Syscall to print the value of space
 	la $a0, nameZ
 	syscall
 	li $v0, 5	# Enter integer
 	syscall
 	sw $v0, z
 formulap1:
 	# ($t0) = z - y + t;
 	lw $t1, z
 	lw $t2, y
 	sub $t0, $t1, $t2
 	lw $t3, t
 	add $t4, $t0, $t3
 	li $v0, 4	# Syscall to print the value of form1
 	la $a0, formula1
 	syscall
 	li $v0, 1	# Syscall to print the value of space
 	la $a0, ($t4)
 	syscall
 formulap2:
 	# t1 = 8 + z
 	lw $t2, z
 	addi $t1, $t2, 8
 	# t0 = t1 * 4
 	sll $t0, $t1, 2
 	# t2 = t - t0
 	lw $t3, t
 	sub $t2, $t3, $t0
 	# t0 = t2 + y
 	lw $t1, y
 	add $t0, $t2, $t1
 	li $v0, 4	# Syscall to print the value of space
 	la $a0, newLine
 	syscall
 	li $v0, 4	# Syscall to print the value of form1
 	la $a0, formula2
 	syscall
 	li $v0, 1	# Syscall to print the value of space
 	la $a0, ($t0)
 	syscall
 exit:	
 	li $v0, 10	#exit
 	syscall