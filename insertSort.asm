.data
array:		.word 34 5 88 4 56 98 7
size:		.word 7
msg:		.asciiz "sorted:\n"
.text
sort_prep:

    la  $t0, array          # load array to $t0.

    lw  $t1, size           # load array size to $t1.

    li  $t2, 1              # loop xloop iter(t2), starting from 1.

sort_xloop:

    la  $t0, array          # load array to $t0.

    bge $t2, $t1, sort_xloop_end    # while (t2 < $t1).

    move    $t3, $t2        # copy $t2 to $t3.

    sort_iloop:

        ble $t3, $zero, sort_iloop_end  # while (t3 > 0).

        la  $t0, array      # load array to $t0.

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

    li  $v0, 4              # 4 = print_string syscall.

    la  $a0, msg    # load sorted_array_string to argument register $a0.

    syscall                 # issue a system call.

    li  $v0, 4              # 4 = print_string syscall.

    la  $a0, msg           # load line to argument register $a0.

    syscall                 # issue a system call.
