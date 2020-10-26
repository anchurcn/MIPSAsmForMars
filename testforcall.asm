.data 
hex:.asciiz "0xFF"
.text 
main:
        addiu   $sp,$sp,-40
        sw      $31,36($sp)
        sw      $fp,32($sp)
        move    $fp,$sp
        sw      $4,40($fp)
        sw      $5,44($fp)
        lw      $2,40($fp)
        nop
        addiu   $3,$2,-1
        lui     $2,%hi(size)
        sw      $3,%lo(size)($2)
        li      $2,1                        # 0x1
        sw      $2,24($fp)
        b       $L7
        nop

$L8:
        lw      $2,24($fp)
        nop
        sll     $2,$2,2
        lw      $3,44($fp)
        nop
        addu    $2,$3,$2
        lw      $3,0($2)
        lw      $2,24($fp)
        nop
        addiu   $2,$2,-1
        move    $5,$2
        move    $4,$3
        jal     storeHex
        nop

        lw      $2,24($fp)
        nop
        addiu   $2,$2,1
        sw      $2,24($fp)
$L7:
        lw      $3,24($fp)
        lw      $2,40($fp)
        nop
        slt     $2,$3,$2
        bne     $2,$0,$L8
        nop

        move    $2,$0
        move    $sp,$fp
        lw      $31,36($sp)
        lw      $fp,32($sp)
        addiu   $sp,$sp,40
        j       $31
        nop
 	
storeHex:
        addiu   $sp,$sp,-32
        sw      $fp,28($sp)
        move    $fp,$sp
        sw      $4,32($fp)
        sw      $5,36($fp)
        li      $2,2                        # 0x2
        sw      $2,16($fp)
        sw      $0,8($fp)
        sb      $0,20($fp)
        b       $L2
        nop

$L5:
        sw      $0,12($fp)
        lb      $2,20($fp)
        slti     $2,$2,65
        beq     $2,$0,$L3
        nop

        lb      $2,20($fp)
        nop
        addiu   $2,$2,-48
        sw      $2,12($fp)
        b       $L4
        nop

$L3:
        lb      $2,20($fp)
        nop
        addiu   $2,$2,-55
        sw      $2,12($fp)
$L4:
        lw      $2,8($fp)
        nop
        sll     $2,$2,4
        sw      $2,8($fp)
        lw      $3,8($fp)
        lw      $2,12($fp)
        nop
        addu    $2,$3,$2
        sw      $2,8($fp)
$L2:
        lw      $2,16($fp)
        lw      $3,32($fp)
        nop
        addu    $2,$3,$2
        lbu     $2,0($2)
        nop
        sb      $2,20($fp)
        lb      $2,20($fp)
        nop
        bne     $2,$0,$L5
        nop

        nop
        move    $sp,$fp
        lw      $fp,28($sp)
        addiu   $sp,$sp,32
        jr      $31