.data
str_buf:.word  0:32 

.text
main:
        addiu   $sp,$sp,-40
        sw      $31,36($sp)
        sw      $fp,32($sp)
        move    $fp,$sp
        li      $2,4567           # 0x11d7
        sw      $2,24($fp)
        li      $6,10                 # 0xa
        la      $5,str_buf
        lw      $4,24($fp)
        jal     itoa
        move    $2,$0
        move    $sp,$fp
        lw      $31,36($sp)
        lw      $fp,32($sp)
        addiu   $sp,$sp,40
        li $v0,10
        syscall
reverse:
        addiu   $sp,$sp,-40
        sw      $31,36($sp)
        sw      $fp,32($sp)
        move    $fp,$sp
        sw      $4,40($fp)
        sw      $5,44($fp)
        sw      $0,24($fp)
        lw      $2,44($fp)
        addiu   $2,$2,-1
        sw      $2,28($fp)
        b       $L4
$L5:
        lw      $2,24($fp)
        lw      $3,40($fp)
        addu    $4,$3,$2
        lw      $2,28($fp)
        lw      $3,40($fp)
        addu    $2,$3,$2
        move    $5,$2
        jal     swap
        lw      $2,24($fp)
        addiu   $2,$2,1
        sw      $2,24($fp)
        lw      $2,28($fp)
        addiu   $2,$2,-1
        sw      $2,28($fp)
$L4:
        lw      $3,24($fp)
        lw      $2,28($fp)
        slt     $2,$3,$2
        bne     $2,$0,$L5
        nop
        move    $sp,$fp
        lw      $31,36($sp)
        lw      $fp,32($sp)
        addiu   $sp,$sp,40
        jr       $31
itoa:
        addiu   $sp,$sp,-48
        sw      $31,44($sp)
        sw      $fp,40($sp)
        move    $fp,$sp
        sw      $4,48($fp)
        sw      $5,52($fp)
        sw      $6,56($fp)
        sw      $0,24($fp)
        sw      $0,28($fp)
        lw      $2,48($fp)
        bne     $2,$0,$L7
        lw      $2,24($fp)
        addiu   $3,$2,1
        sw      $3,24($fp)
        move    $3,$2
        lw      $2,52($fp)
        addu    $2,$2,$3
        li      $3,48                 # 0x30
        sb      $3,0($2)
        lw      $2,24($fp)
        lw      $3,52($fp)
        addu    $2,$3,$2
        sb      $0,0($2)
        lw      $2,52($fp)
        b       $L8
$L7:
        lw      $2,48($fp)
        bgez    $2,$L10
        lw      $3,56($fp)
        li      $2,10                 # 0xa
        bne     $3,$2,$L10
        li      $2,1                        # 0x1
        sw      $2,28($fp)
        lw      $2,48($fp)
        subu    $2,$0,$2
        sw      $2,48($fp)
        b       $L10
$L13:
        lw      $3,48($fp)
        lw      $2,56($fp)
        bne     $2,$0,tag1
        div     $0,$3,$2
        break   7
tag1:
        mfhi    $2
        sw      $2,32($fp)
        lw      $2,24($fp)
        addiu   $3,$2,1
        sw      $3,24($fp)
        move    $3,$2
        lw      $2,52($fp)
        addu    $3,$2,$3
        lw      $2,32($fp)
        slti     $2,$2,10
        bne     $2,$0,$L11
        lw      $2,32($fp)
        andi    $2,$2,0x00ff
        addiu   $2,$2,87
        andi    $2,$2,0x00ff
        sll     $2,$2,24
        sra     $2,$2,24
        b       $L12
$L11:
        lw      $2,32($fp)
        andi    $2,$2,0x00ff
        addiu   $2,$2,48
        andi    $2,$2,0x00ff
        sll     $2,$2,24
        sra     $2,$2,24
$L12:
        sb      $2,0($3)
        lw      $3,48($fp)
        lw      $2,56($fp)
        bne     $2,$0,tag2
        div     $0,$3,$2
        break   7
tag2:
        mfhi    $2
        mflo    $2
        sw      $2,48($fp)
$L10:
        lw      $2,48($fp)
        bne     $2,$0,$L13
        lw      $2,28($fp)
        beq     $2,$0,$L14
        lw      $2,24($fp)
        addiu   $3,$2,1
        sw      $3,24($fp)
        move    $3,$2
        lw      $2,52($fp)
        addu    $2,$2,$3
        li      $3,45                 # 0x2d
        sb      $3,0($2)
$L14:
        lw      $2,24($fp)
        lw      $3,52($fp)
        addu    $2,$3,$2
        sb      $0,0($2)
        lw      $5,24($fp)
        lw      $4,52($fp)
        jal     reverse
        lw      $2,52($fp)
$L8:
        move    $sp,$fp
        lw      $31,44($sp)
        lw      $fp,40($sp)
        addiu   $sp,$sp,48
        jr       $31
swap:
        addiu   $sp,$sp,-24
        sw      $fp,20($sp)
        move    $fp,$sp
        sw      $4,24($fp)
        sw      $5,28($fp)
        lw      $2,24($fp)
        lbu     $2,0($2)
        sb      $2,8($fp)
        lw      $2,28($fp)
        lb      $3,0($2)
        lw      $2,24($fp)
        sb      $3,0($2)
        lw      $2,28($fp)
        lbu     $3,8($fp)
        sb      $3,0($2)
        nop
        move    $sp,$fp
        lw      $fp,20($sp)
        addiu   $sp,$sp,24
        jr       $31