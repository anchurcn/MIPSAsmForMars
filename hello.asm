.data
str:	.asciiz "hello world!\n"
temp:	.word 0
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
start:
	
main:
        addiu   $sp,$sp,-40		#main
        sw      $31,36($sp)
        sw      $fp,32($sp)
        move    $fp,$sp
        li      $5,9                        # 0x9
        li      $4,8                        # 0x8
        jal     add
        nop

        sw      $2,24($fp)
        move    $2,$0
        move    $sp,$fp
        lw      $31,36($sp)
        lw      $fp,32($sp)
        addiu   $sp,$sp,40
        j final

add:
        addiu   $sp,$sp,-8		#add
        sw      $fp,4($sp)
        move    $fp,$sp
        sw      $4,8($fp)
        sw      $5,12($fp)
        lw      $3,8($fp)
        lw      $2,12($fp)
        nop
        addu    $2,$3,$2
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        jr       $31
        nop
final:
	exit
