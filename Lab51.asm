#lab5
#------------------------------------------------------------------------
# stack op macros
#------------------------------------------------------------------------
#save S register
.macro save_s
	addiu	$sp,$sp,-32
	sw	$s0,0($sp)
	sw	$s1,4($sp)
	sw	$s2,8($sp)
	sw	$s3,12($sp)
	sw	$s4,16($sp)
	sw	$s5,20($sp)
	sw	$s6,24($sp)
	sw	$s7,28($sp)
.end_macro
#-------------------------------------------------------------------------
#restore S register
.macro restore_s
	lw	$s0,0($sp)
	lw	$s1,4($sp)
	lw	$s2,8($sp)
	lw	$s3,12($sp)
	lw	$s4,16($sp)
	lw	$s5,20($sp)
	lw	$s6,24($sp)
	lw	$s7,28($sp)
	addiu	$sp,$sp,32
.end_macro
#-------------------------------------------------------------------------
.macro get_coord(%input,%x,%y)
	sra	%x,%input,16
	andi	%y,%input,0xff
.end_macro
#-------------------------------------------------------------------------
.macro format_coord(%output,%x,%y)
	sll	%output,%x,16
	addu	%output,%output,%y
.end_macro
#-------------------------------------------------------------------------
.data
originAddress:.word 0xffff0000


.text
#------------------------------------------------------------------------
#bitmap op
clear_bitmap:
        lw      $v1,originAddress
        addi	$v1,$v1,65536		#128*128*4
        lw      $v0,originAddress
loop1:
        sw      $a0,0($v0)
        addiu   $v0,$v0,4
        bne     $v0,$v1,loop1		#loop for every pixel
        jr      $ra
#-----------------------------------------------------------------------
draw_pixel:
        andi    $v0,$a0,0xff		#get y part
        sll     $v0,$v0,7		#y*128
        sra     $a0,$a0,16		#get x part
        addu    $a0,$v0,$a0
        sll     $a0,$a0,2		#(y*128+x)*4
        lw      $v0,originAddress
        addu    $a0,$v0,$a0		#base+offset=where the pixel is
        sw      $a1,0($a0)
        jr      $ra
#----------------------------------------------------------------------
get_pixel:
        andi    $v0,$a0,0xff
        sll     $v0,$v0,7
        sra     $a0,$a0,16
        addu    $a0,$v0,$a0
        sll     $a0,$a0,2
        lw      $v0,originAddress
        addu    $a0,$v0,$a0
        lw      $v0,0($a0)
        jr      $ra




#------------------------------------------------------------
# draw circle
draw_circle:
	push($ra)
	save_s
	move	$s0,$a0			#save coord,r,color
	move	$s1,$a1
	move	$s2,$a2
	li	$s5,0			#$s5=x=0
	move	$s3,$s1
	mul	$t0,$s1,-2
	add	$s4,$t0,3
	#prepare args for call
	move	$a0,$s0
	move	$a1,$s2
	move	$a2,$s5
	move	$a3,$s3
	jal	draw_circle_pixel
while:
	blt	$s3,$s5,whileF
	
	addi	$s5,$s5,1
	ble	$s4,0,else
		addi	$s3,$s3,-1		#y--
		sub	$t0,$s5,$s3		#d = d + 4 * (x - y) + 10;
		mul	$t0,$t0,4
		add	$t0,$t0,$s4
		addi	$s4,$t0,10
		j	endif
	else:
		mul	$t0,$s5,4		#d=d+4*x+6;
		add	$t0,$t0,$s4
		addi	$s4,$t0,6
	endif:
	move	$a0,$s0			#prepare for call
	move	$a1,$s2
	move	$a2,$s5
	move	$a3,$s3
	jal	draw_circle_pixel
	j	while
whileF:
	restore_s
	pop($ra)
	jr	$ra
	
	
#-------------------------------------------------------------
#draw_circle_pixel
draw_circle_pixel:
	push($ra)
	save_s
	get_coord($a0,$s0,$s1)
	add	$t0,$s0,$a2		#coord=((xpart+x)<<16)+(ypart+y);
	add	$t1,$s1,$a3
	format_coord($a0,$t0,$t1)
	jal	draw_pixel		#assume a3,a1,a2 not change here
	sub	$t0,$s0,$a2		#coord=((xpart-x)<<16)+(ypart+y);
	add	$t1,$s1,$a3
	format_coord($a0,$t0,$t1)
	jal	draw_pixel
	add	$t0,$s0,$a2		#coord=((xpart+x)<<16)+(ypart-y);
	sub	$t1,$s1,$a3
	format_coord($a0,$t0,$t1)
	jal	draw_pixel
	sub	$t0,$s0,$a2		#coord=((xpart-x)<<16)+(ypart-y);
	sub	$t1,$s1,$a3
	format_coord($a0,$t0,$t1)
	jal	draw_pixel
	
	add	$t0,$s0,$a3		#coord=((xpart+y)<<16)+(ypart+x);
	add	$t1,$s1,$a2
	format_coord($a0,$t0,$t1)
	jal	draw_pixel
	sub	$t0,$s0,$a3		#coord=((xpart-y)<<16)+(ypart+x);
	add	$t1,$s1,$a2
	format_coord($a0,$t0,$t1)
	jal	draw_pixel
	add	$t0,$s0,$a3		#coord=((xpart+y)<<16)+(ypart-x);
	sub	$t1,$s1,$a2
	format_coord($a0,$t0,$t1)
	jal	draw_pixel
	sub	$t0,$s0,$a3		#coord=((xpart-y)<<16)+(ypart-x);
	sub	$t1,$s1,$a2
	format_coord($a0,$t0,$t1)
	jal	draw_pixel
	
	
	restore_s
	pop($ra)
	jr	$ra
#--------------------------------------------------------------------------
#draw_solid_circle
draw_solid_circle:
	push($ra)
	save_s
	#-------------
	move	$s0,$a1			#save r to $s0
	push($a2)			#push color
	get_coord($a0,$s1,$s2)
	sub	$s3,$s1,$s0		
	add	$s4,$s1,$s0
	sub	$s5,$s2,$s0
	add	$s6,$s2,$s0
	
for1:
	bgt	$s3,$s4,for1_end
	#----for body
	move	$s7,$s5			#<init>
	for2:
		bgt	$s7,$s6,for2_end
		#---for body
		sub	$t0,$s3,$s1	#expression for calc delta
		sub	$t1,$s3,$s1
		mul	$t3,$t0,$t1
		sub	$t0,$s7,$s2
		sub	$t1,$s7,$s2
		mul	$t4,$t0,$t1
		add	$t0,$t3,$t4	#$t0=delta
		mul	$t1,$s0,$s0
		bge	$t0,$t1,dge	#delta grater or equal to r*r
		format_coord($a0,$s3,$s7)
		lw	$a1,0($sp)	#load the color var from stack
		jal	draw_pixel
	dge:
		#---
		addi	$s7,$s7,1
		j	for2
	for2_end:
	#----
	addi	$s3,$s3,1
	j	for1
for1_end:
	pop($a2)		#pop color
	#-------------
	restore_s
	pop($ra)
	jr	$ra