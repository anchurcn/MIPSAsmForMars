.data
size:
        .word   10
arr:
        .word   1:10
.text
main:
        addiu   $sp,$sp,-32
        sw      $31,28($sp)
        sw      $fp,24($sp)
        move    $fp,$sp
        jal     fill_arr
        nop
        move    $sp,$fp
        lw      $31,28($sp)
        lw      $fp,24($sp)
        addiu   $sp,$sp,32
        li $v0,10
        syscall
fill_arr:
        addiu   $sp,$sp,-24
        sw      $fp,20($sp)
        move    $fp,$sp
        sw      $0,8($fp)
        b       $L3
$L4:
        la      $3,arr
        lw      $2,8($fp)
        sll     $2,$2,2
        addu    $2,$3,$2
        lw      $3,8($fp)
        sw      $3,0($2)
        lw      $2,8($fp)
        addiu   $2,$2,1
        sw      $2,8($fp)
$L3:
        la      $2,size
        lw      $2,0($2)
        lw      $3,8($fp)
        slt     $2,$3,$2
        bne     $2,$0,$L4
        nop
        move    $sp,$fp
        lw      $fp,20($sp)
        addiu   $sp,$sp,24
        jr       $31