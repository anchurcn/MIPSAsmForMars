.data
str_buf:
        .byte 0:16  #"hello world!\000"
str_len:
$LC0:
        .ascii  "HelloWorld\000"

.text
store_string:
        addiu   $sp,$sp,-40
        sw      $fp,36($sp)
        move    $fp,$sp
        lw      $3,str_len
        lw      $2,str_len+4
        sw      $3,16($fp)
        sw      $2,20($fp)
        lhu     $2,$LC0+8
        sh      $2,24($fp)
        lbu     $2,$LC0+10
        sb      $2,26($fp)
        sw      $0,8($fp)
        b       $L2
$L3:
        lw      $2,8($fp)
        addiu   $2,$2,1
        sw      $2,8($fp)
$L2:
        lw      $2,8($fp)
        addiu   $3,$fp,8
        addu    $2,$3,$2
        lb      $2,8($2)
        bne     $2,$0,$L3
        la      $2,str_len
        lw      $3,8($fp)
        sw      $3,0($2)
        sw      $0,12($fp)
        sw      $0,12($fp)
        b       $L4
$L7:
        lw      $2,12($fp)
        addiu   $3,$fp,8
        addu    $2,$3,$2
        lb      $2,8($2)
        slti     $2,$2,91
        bne     $2,$0,$L5
        lw      $2,12($fp)
        addiu   $3,$fp,8
        addu    $2,$3,$2
        lb      $2,8($2)
        andi    $2,$2,0x00ff
        addiu   $2,$2,-32
        andi    $2,$2,0x00ff
        sll     $3,$2,24
        sra     $3,$3,24
        la      $4,str_buf
        lw      $2,12($fp)
        addu    $2,$4,$2
        sb      $3,0($2)
        b       $L6
$L5:
        lw      $2,12($fp)
        addiu   $3,$fp,8
        addu    $2,$3,$2
        lb      $3,8($2)
        la      $4,str_buf
        lw      $2,12($fp)
        addu    $2,$4,$2
        sb      $3,0($2)
$L6:
        lw      $2,12($fp)
        addiu   $2,$2,1
        sw      $2,12($fp)
$L4:
        la      $2,str_len
        lw      $2,0($2)
        lw      $3,12($fp)
        slt     $2,$3,$2
        bne     $2,$0,$L7
        li $v0,10
        syscall
        nop
        move    $sp,$fp
        lw      $fp,36($sp)
        addiu   $sp,$sp,40
        jr       $31