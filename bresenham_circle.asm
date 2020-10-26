
#------------------------------------------------------------
# draw circle
draw_circle:
	push($ra)
	save_s
	move	r,$a1
	move	color,$a2
	get_coord(coord,xc,yc)
	li	x,0
	move	y,r
	mul	$t0,r,-2
	add	d,$t0,3
	#prepare args for call
	move	$a1,color
	move	$a2,x
	move	$a3,y
	jal	draw_circle_pixel
while:
	blt	y,x,whileF
	
	addi	x,x,1
	ble	d,0,else
		addi	y,y,-1
		sub	$t0,x,y
		mul	$t0,$t0,4
		add	$t0,$t0,d
		addi	d,$t0,10
		j	endif
	else:
		mul	$t0,x,4		#d=d+4*x+6;
		add	$t0,$t0,d
		addi	d,$t0,6
	endif:
	move	$a2,x
	move	$a3,y
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
	store_s
	get_coord($a0,xp,yp)
	add	$t0,xp,$a2		#coord=((xpart+x)<<16)+(ypart+y);
	add	$t1,yp,$a3
	format_coord($a0,$t0,$t1)
	jal	draw_pixel		#assume a3,a1,a2 not change here
	sub	$t0,xp,$a2		#coord=((xpart-x)<<16)+(ypart+y);
	add	$t1,yp,$a3
	format_coord($a0,$t0,$t1)
	jal	draw_pixel
	add	$t0,xp,$a2		#coord=((xpart+x)<<16)+(ypart-y);
	sub	$t1,yp,$a3
	format_coord($a0,$t0,$t1)
	jal	draw_pixel
	sub	$t0,xp,$a2		#coord=((xpart-x)<<16)+(ypart-y);
	sub	$t1,yp,$a3
	format_coord($a0,$t0,$t1)
	jal	draw_pixel
	
	add	$t0,xp,$a3		#coord=((xpart+y)<<16)+(ypart+x);
	add	$t1,yp,$a2
	format_coord($a0,$t0,$t1)
	jal	draw_pixel
	sub	$t0,xp,$a3		#coord=((xpart-y)<<16)+(ypart+x);
	add	$t1,yp,$a2
	format_coord($a0,$t0,$t1)
	jal	draw_pixel
	add	$t0,xp,$a3		#coord=((xpart+y)<<16)+(ypart-x);
	sub	$t1,yp,$a2
	format_coord($a0,$t0,$t1)
	jal	draw_pixel
	sub	$t0,xp,$a3		#coord=((xpart-y)<<16)+(ypart-x);
	sub	$t1,yp,$a2
	format_coord($a0,$t0,$t1)
	jal	draw_pixel
	
	
	restore_s
	pop($ra)
	jr	$ra
	
	
	
	
	
	
	
	
	
	
	
	
	
	