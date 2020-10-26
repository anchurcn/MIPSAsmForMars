	#Library of Drawing Primitives in MIPS Assembly Language
	
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 	
	#																								#
	# Drawing Primitive functions:																	#
	# 																								#
	#																								#	
	# These are the four basic functions being implemented in the program:							#
	#																								#
	#																								#
	# SetPixel(int x, int y, int colour) 															#
	# Draws a pixel at specified co-ordinates and colour											#
	#																								#
	#																								#
	# DrawLine(int x1, int y1, int x2, int y2, int colour) 											#
	# Draws a line between two points of a specified colour using Bresenham's line drawing			#
	# algorithm																						#
	#																								#
	#																								#
	# DrawRectangle(int x, int y, int width, int height, int colour)								#
	# Draws a rectangle based on a co-ordinate and the width and height to extend it from			#
	# that point, and the colour the outline of it will be drawn in									#
	#																								#
	#																								#
	# DrawPolygon(point[] points, int count, int colour)											#
	# Draws a polygon of a number of points, and the colour the outline will be drawn in			#
	# The Point is a struck in the form:															#
	#																								#
	#	struct point																				#
	#	{																							#
	#	   int x																					#
	#	   int y																					#
	#	}																							#
	#																								#
	# These are the advanced functions that have been implemented:									#
	#																								#
	#																								#
	# FillRectangle(int x, int y, int width, int height, int colour)								#
	# Fills a rectangle based on a co-ordinate and the width and height from that point and			#
	# the colour that it will be filled with														#
	#																								#
	#																								#
	# DrawCircle(int cx, int cy, int radius, int colour)											#
	# Draws a circle based on a centre co-ordinate and a radius using the midpoint circle 			#
	# algorithm. It is then drawn with the outline of the colour specified							#
	#																								#
	#																								#
	# FillCircle (int cx, int cy, int radius, int colour)											#
	# Draws a circle based on a centre co-ordinate and a radius using the midpoint circle 			#
	# algorithm. It is then drawn with the outline of the colour specified							#
	#																								#
	#																								#
	# DrawDashedLine(int x1, int y1, int x2, int y2, int dash, int space, int colour) 				#	 
	# Draws a line between two points of a specified colour using Bresenham's line drawing			#
	# algorithm. Creates dashed and space between dahsed of specified length						#
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #  
		
	.data
bitmaparea: .space 524288 # Reserve the data section being used by the bitmap display (512 x 256 bytes)	
display1: .asciiz "\nEnter 1 to run the setpixel subroutine "
display2: .asciiz "\nEnter 2 to run the drawline subroutine"
display3: .asciiz "\nEnter 3 to run the drawrectangle subroutine"
display4: .asciiz "\nEnter 4 to run the drawpolygon subroutine"
display5: .asciiz "\nEnter 5 to run the fillrectangle subroutine"
display6: .asciiz "\nEnter 6 to run the drawcircle subroutine"
display7: .asciiz "\nEnter 7 to run the fillcircle subroutine"
display8: .asciiz "\nEnter 8 to run the dashedline subroutine\n"
runagain: .asciiz "\nTo run another drawing primative enter 1, to exit enter 2"
bitmapreset: .asciiz "\nRemember to reset the bitmap display if running again\n"
	.text

main:			
	la $a0, display1		# Sets $a0 to the value of string "display1"
	ori $v0, $zero, 4		# Sets $v0 in preperation for a system call
	syscall				# Displays the string to screen
	
	la $a0, display2		# Sets $a0 to the value of string "display2"
	ori $v0, $zero, 4		# Sets $v0 in preperation for a system call
	syscall				# Displays the string to screen
	
	la $a0, display3		# Sets $a0 to the value of string "display3"
	ori $v0, $zero, 4		# Sets $v0 in preperation for a system call
	syscall				# Displays the string to screen
	
	la $a0, display4		# Sets $a0 to the value of string "display4"
	ori $v0, $zero, 4		# Sets $v0 in preperation for a system call
	syscall				# Displays the string to screen
	
	la $a0, display5		# Sets $a0 to the value of string "display5"
	ori $v0, $zero, 4		# Sets $v0 in preperation for a system call
	syscall				# Displays the string to screen
	
	la $a0, display6		# Sets $a0 to the value of string "display6"
	ori $v0, $zero, 4		# Sets $v0 in preperation for a system call
	syscall				# Displays the string to screen
	
	la $a0, display7		# Sets $a0 to the value of string "display7"
	ori $v0, $zero, 4		# Sets $v0 in preperation for a system call
	syscall				# Displays the string to screen
	
	la $a0, display8		# Sets $a0 to the value of string "display8"
	ori $v0, $zero, 4		# Sets $v0 in preperation for a system call
	syscall				# Displays the string to screen
	
	ori $v0, $zero, 5		# Reads an integer from the keyboard
        syscall				# The integer returned is stored in $v0
        
	beq $v0, 1, runsetpixel			# Runs setpixel examples
	nop        

	beq $v0, 2, rundrawline			# Runs drawline examples
	nop
	
	beq $v0, 3, rundrawrectangle	# Runs drawrectangle examples
	nop
	
	beq $v0, 4, rundrawpolygon		# Runs drawpolygon examples
	nop
	
	beq $v0, 5, runfillrectangle	# Runs fillpolygon examples
	nop
	
	beq $v0, 6, rundrawcircle		# Runs drawcircle examples
	nop

	beq $v0, 7, runfillcircle 		# Runs fillcircle examples
	nop
	
	beq $v0, 8, rundashedlines		# Run dashedlines examples
	nop
	
primitiveran:
	
	la $a0, runagain		# Sets $a0 to the value of string "runagain"
	ori $v0, $zero, 4		# Sets $v0 in preperation for a system call
	syscall					# Displays the string to screen
	
	la $a0, bitmapreset		# Sets $a0 to the value of string "bitmapreset"
	ori $v0, $zero, 4		# Sets $v0 in preperation for a system call
	syscall					# Displays the string to screen
	
	ori $v0, $zero, 5		# Reads an integer from the keyboard
        syscall				# The integer returned is stored in $v0
        
        beq $v0, 1, main	# Branch back to the main program
	
	li $v0, 10         		# Sets $v0 in preperation for a system call.
      	syscall 			# Exits the program


runsetpixel:
	# Demonstrates the setpixel function (int x, int y, int colour)
	
	li $a0, 200 		# Load the x co-ordinate (200) into the register $a0 ready to 
						# be passed into the subroutine
	li $a1, 100			# Load the y co-ordinate (100) into the register $a1 ready to 
						# be passed into the subroutine 
	li $a2, 0x00FFFFFF 	# Load the colour of the pixel (white) into the register $a2 ready to 
						# be passed into the subroutine
		
	jal setpixel		# Enter the subroutine "setpixel"
	nop
	
	li $a0, 300 		# Load the x co-ordinate (300) into the register $a0 ready to 
						# be passed into the subroutine
	li $a1, 100			# Load the y co-ordinate (100) into the register $a1 ready to 
						# be passed into the subroutine 
	li $a2, 0x00FF00FF 	# Load the colour of the pixel (purple) into the register $a2 ready to 
						# be passed into the subroutine
		
	jal setpixel		# Enter the subroutine "setpixel"
	nop
	
	li $a0, 300 		# Load the x co-ordinate (300) into the register $a0 ready to 
						# be passed into the subroutine
	li $a1, 200			# Load the y co-ordinate (200) into the register $a1 ready to 
						# be passed into the subroutine 
	li $a2, 0x0000FF00 	# Load the colour of the pixel (green) into the register $a2 ready to 
						# be passed into the subroutine
		
	jal setpixel		# Enter the subroutine "setpixel"
	nop
	
	li $a0, 200 		# Load the x co-ordinate (200) into the register $a0 ready to 
						# be passed into the subroutine
	li $a1, 200			# Load the y co-ordinate (200) into the register $a1 ready to 
						# be passed into the subroutine 
	li $a2, 0x00FF0000 	# Load the colour of the pixel (red) into the register $a2 ready to 
						# be passed into the subroutine
		
	jal setpixel		# Enter the subroutine "setpixel"
	nop
	
	j primitiveran		# Jumps back to the main when the subroutine is finished
	nop
	
	
rundrawline:	
	# Demonstrates the drawline function (int x1, int y1, int x2, int y2, int colour)
	
	li $a0, 49			# Load the x co-ordinate (49) of point 1 into the register $a0 ready to 
						# be passed into the subroutine
    li $a1, 49			# Load the y co-ordinate (49) of point 1 into the register $a1 ready to 
						# be passed into the subroutine
    li $a2, 99			# Load the x co-ordinate (99) of point 2 into the register $a2 ready to 
						# be passed into the subroutine
    li $a3, 99			# Load the y co-ordinate (99) of point 2 into the register $a3 ready to 
						# be passed into the subroutine
    li $t9, 0x00FF0000	# Load the colour of the line (red) into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack
	
	jal drawline		# Enter the subroutine "drawline"
	nop
	
	li $a0, 99			# Load the x co-ordinate (99) of point 1 into the register $a0 ready to 
						# be passed into the subroutine
    li $a1, 49			# Load the y co-ordinate (49) of point 1 into the register $a1 ready to 
						# be passed into the subroutine
    li $a2, 199			# Load the x co-ordinate (199) of point 2 into the register $a2 ready to 
						# be passed into the subroutine
    li $a3, 49			# Load the y co-ordinate (49) of point 2 into the register $a3 ready to 
						# be passed into the subroutine
    li $t9, 0x00FFFFFF	# Load the colour of the line (white) into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack
	
	jal drawline		# Enter the subroutine "drawline"
	nop
	
	li $a0, 200			# Load the x co-ordinate (200) of point 1 into the register $a0 ready to 
						# be passed into the subroutine
    li $a1, 200			# Load the y co-ordinate (200) of point 1 into the register $a1 ready to 
						# be passed into the subroutine
    li $a2, 200			# Load the x co-ordinate (200) of point 2 into the register $a2 ready to 
						# be passed into the subroutine
    li $a3, 100			# Load the y co-ordinate (100) of point 2 into the register $a3 ready to 
						# be passed into the subroutine
    li $t9, 0x00FF00FF	# Load the colour of the line (purple) into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack
	
	jal drawline		# Enter the subroutine "drawline"
	nop
	
	li $a0, 350			# Load the x co-ordinate (350) of point 1 into the register $a0 ready to 
						# be passed into the subroutine
    li $a1, 200			# Load the y co-ordinate (200) of point 1 into the register $a1 ready to 
						# be passed into the subroutine
    li $a2, 500			# Load the x co-ordinate (500) of point 2 into the register $a2 ready to 
						# be passed into the subroutine
    li $a3, 50			# Load the y co-ordinate (50) of point 2 into the register $a3 ready to 
						# be passed into the subroutine
    li $t9, 0x000000FF	# Load the colour of the line (blue) into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack
	
	jal drawline		# Enter the subroutine "drawline"
	nop
	
	j primitiveran		# Jumps back to the main when the subroutine is finished
	nop
	

rundrawrectangle:	
	# Demonstrates the drawrectangle function (int x, int y, int width, int height, int colour)
	
	li $a0, 350			# Load the x co-ordinate (350) of the first vertex into the register $a0 ready to 
						# be passed into the subroutine
    li $a1, 100			# Load the y co-ordinate (100) of the first vertex into the register $a1 ready to 
						# be passed into the subroutine
    li $a2, 150			# Load the width (150) of the rectangle into the register $a2 ready to 
						# be passed into the subroutine
    li $a3, 100			# Load the height (100) of the rectangle into the register $a3 ready to 
						# be passed into the subroutine
    li $t9, 0x0000FF00	# Load the colour of the rectangle (green) into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack
	
	jal drawrectangle	# Enter the subroutine "drawrectangle"
	nop
	
	li $a0, 10			# Load the x co-ordinate (10) of the first vertex into the register $a0 ready to 
						# be passed into the subroutine
    li $a1, 10			# Load the y co-ordinate (10) of the first vertex into the register $a1 ready to 
						# be passed into the subroutine
    li $a2, 100			# Load the width (100) of the rectangle into the register $a2 ready to 
						# be passed into the subroutine
    li $a3, 25			# Load the height (25) of the rectangle into the register $a3 ready to 
						# be passed into the subroutine
    li $t9, 0x00FFFFFF	# Load the colour of the rectangle (white) into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack
	
	jal drawrectangle	# Enter the subroutine "drawrectangle"
	nop
	
	li $a0, 50			# Load the x co-ordinate (50) of the first vertex into the register $a0 ready to 
						# be passed into the subroutine
    li $a1, 50			# Load the y co-ordinate (50) of the first vertex into the register $a1 ready to 
						# be passed into the subroutine
    li $a2, 25			# Load the width (25) of the rectangle into the register $a2 ready to 
						# be passed into the subroutine
    li $a3, 100			# Load the height (100) of the rectangle into the register $a3 ready to 
						# be passed into the subroutine
    li $t9, 0x000000FF	# Load the colour of the rectangle (blue) into $t0 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t0 (which is now the value of the colour paramter) to the stack
	
	jal drawrectangle	# Enter the subroutine "drawrectangle"
	nop
	
	li $a0, 200			# Load the x co-ordinate (200) of the first vertex into the register $a0 ready to 
						# be passed into the subroutine
    li $a1, 100			# Load the y co-ordinate (100) of the first vertex into the register $a1 ready to 
						# be passed into the subroutine
    li $a2, 100			# Load the width (100) of the rectangle into the register $a2 ready to 
						# be passed into the subroutine
    li $a3, 100			# Load the height (100) of the rectangle into the register $a3 ready to 
						# be passed into the subroutine
    li $t9, 0x00FF00FF	# Load the colour of the rectangle (purple) into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack
	
	jal drawrectangle	# Enter the subroutine "drawrectangle"
	nop
	
	j primitiveran		# Jumps back to the main when the subroutine is finished
	nop
	
	
rundrawpolygon:
	# Demonstrates the drawPolygon function (point[] points, int count, int colour)
	
	
	# To store the array of points the array is stored in the .data section
	# To store the struct in the array, every 8 bytes of date is each struct object in the struct
	# since one array element is 4 bytes, the point struct has two values it is twice the length, so every 
	# 8 bytes of data is a new struct object
	
	.data
array1: .word 500, 50, 500, 150, 400, 150						 							# Array of 3 vertices 	
array2: .word 300, 200, 350, 225, 325, 250, 275, 250, 250, 225 			         			# Array of five vertices
array3: .word 40, 10, 80, 10, 110, 50, 80, 90, 40, 90, 10, 50				 				# Array of six vertices
array4: .word 200, 50, 250, 50, 275, 75, 275, 125, 250, 150, 200, 150, 175, 125, 175, 75 	# Array of eight vertices 
	.text
	la $a0, array1		# Load the array of points into the register $a0 ready to be passed into the subroutine
	li $a1, 3 			# Load the count variable (number of side of the polygon) into the register $a1 ready to 
						# be passed into the subroutine
	li $a2, 0x0000FFFF	# Load the colour of polygon (light blue) into the register $a2 ready to 
						# be passed into the subroutine
		
	jal drawpolygon		# Runs the subroutine "drawpolygon"
	nop
	
	la $a0, array2		# Load the array of points into the register $a0 ready to be passed into the subroutine
	li $a1, 5 			# Load the count variable (number of side of the polygon) into the register $a1 ready to 
						# be passed into the subroutine
	li $a2, 0x000000FF	# Load the colour of polygon (blue) into the register $a2 ready to 
						# be passed into the subroutine
		
	jal drawpolygon		# Runs the subroutine "drawpolygon"
	nop
	
	la $a0, array3		# Load the array of points into the register $a0 ready to be passed into the subroutine
	li $a1, 6 			# Load the count variable (number of side of the polygon) into the register $a1 ready to 
						# be passed into the subroutine
	li $a2, 0x0000FF00	# Load the colour of polygon (green) into the register $a2 ready to 
						# be passed into the subroutine
		
	jal drawpolygon		# Runs the subroutine "drawpolygon"
	nop
	
	la $a0, array4		# Load the array of points into the register $a0 ready to be passed into the subroutine
	li $a1, 8 			# Load the count variable (number of side of the polygon) into the register $a1 ready to 
						# be passed into the subroutine
	li $a2, 0x00FF0000	# Load the colour of polygon (red) into the register $a2 ready to 
						# be passed into the subroutine
		
	jal drawpolygon		# Runs the subroutine "drawpolygon"
	nop
	
	j primitiveran		# Jumps back to the main when the subroutine is finished
	nop
	
	
runfillrectangle:
	# Demonstrates the drawrectangle function (int x, int y, int width, int height, int colour)
	
	li $a0, 350			# Load the x co-ordinate (350) of the first vertex into the register $a0 ready to 
						# be passed into the subroutine
    li $a1, 100			# Load the y co-ordinate (100) of the first vertex into the register $a1 ready to 
						# be passed into the subroutine
    li $a2, 150			# Load the width (150) of the rectangle into the register $a2 ready to 
						# be passed into the subroutine
    li $a3, 100			# Load the height (100) of the rectangle into the register $a3 ready to 
						# be passed into the subroutine
    li $t9, 0x0000FF00	# Load the colour of the rectangle (green) into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack
	
	jal fillrectangle	# Enter the subroutine "drawrectangle"
	nop
	
	
	li $a0, 10			# Load the x co-ordinate (10) of the first vertex into the register $a0 ready to 
						# be passed into the subroutine
    li $a1, 10			# Load the y co-ordinate (10) of the first vertex into the register $a1 ready to 
						# be passed into the subroutine
    li $a2, 100			# Load the width (100) of the rectangle into the register $a2 ready to 
						# be passed into the subroutine
    li $a3, 25			# Load the height (25) of the rectangle into the register $a3 ready to 
						# be passed into the subroutine
    li $t9, 0x00FFFFFF	# Load the colour of the rectangle (white) into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack
	
	jal fillrectangle	# Enter the subroutine "drawrectangle"
	nop
		
	li $a0, 50			# Load the x co-ordinate (50) of the first vertex into the register $a0 ready to 
						# be passed into the subroutine
    li $a1, 50			# Load the y co-ordinate (50) of the first vertex into the register $a1 ready to 
						# be passed into the subroutine
    li $a2, 25			# Load the width (25) of the rectangle into the register $a2 ready to 
						# be passed into the subroutine
    li $a3, 100			# Load the height (100) of the rectangle into the register $a3 ready to 
						# be passed into the subroutine
    li $t9, 0x000000FF	# Load the colour of the rectangle (blue) into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack
	
	jal fillrectangle	# Enter the subroutine "drawrectangle"
	nop
	
	li $a0, 200			# Load the x co-ordinate (200) of the first vertex into the register $a0 ready to 
						# be passed into the subroutine
    li $a1, 100			# Load the y co-ordinate (100) of the first vertex into the register $a1 ready to 
						# be passed into the subroutine
    li $a2, 100			# Load the width (100) of the rectangle into the register $a2 ready to 
						# be passed into the subroutine
    li $a3, 100			# Load the height (100) of the rectangle into the register $a3 ready to 
						# be passed into the subroutine
    li $t9, 0x00FF00FF	# Load the colour of the rectangle (purple) into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack
	
	jal fillrectangle	# Enter the subroutine "drawrectangle"
	nop
	
	j primitiveran		# Jumps back to the main when the subroutine is finished
	nop
	     		
      	
rundrawcircle:

	li $a0, 50			# Load the x co-ordinate of the centre point (50) into the register $a0 ready to
						# be passed into the subroutine
	li $a1, 50			# Load the y co-ordinate of the centre point (50) into the register $a1 ready to
						# be passed into the subroutine
	li $a2, 25			# Load the radius (25) into the register $a2 ready to be passed into the subroutine
	li $a3, 0x00FFFFFF	# Load the colour (white) into the register $a3 ready to be passed into the subroutine
	
	jal drawcircle		# Enter the subroutine "drawcircle"
	nop
	
	li $a0, 450			# Load the x co-ordinate of the centre point (450) into the register $a0 ready to
						# be passed into the subroutine
	li $a1, 200			# Load the y co-ordinate of the centre point (200) into the register $a1 ready to
						# be passed into the subroutine
	li $a2, 50			# Load the radius (50) into the register $a2 ready to be passed into the subroutine
	li $a3, 0x00FF00FF	# Load the colour (purple) into the register $a3 ready to be passed into the subroutine
	
	jal drawcircle		# Enter the subroutine "drawcircle"
	nop
	
	li $a0, 200			# Load the x co-ordinate of the centre point (200) into the register $a0 ready to
						# be passed into the subroutine
	li $a1, 150			# Load the y co-ordinate of the centre point (150) into the register $a1 ready to
						# be passed into the subroutine
	li $a2, 100			# Load the radius (100) into the register $a2 ready to be passed into the subroutine
	li $a3, 0x00FF0000	# Load the colour (red) into the register $a3 ready to be passed into the subroutine
	
	jal drawcircle		# Enter the subroutine "drawcircle"
	nop
	
	li $a0, 400			# Load the x co-ordinate of the centre point (400) into the register $a0 ready to 
						# be passed into the subroutine
	li $a1, 100			# Load the y co-ordinate of the centre point (100) into the register $a1 ready to 
						# be passed into the subroutine
	li $a2, 10			# Load the radius (10) into the register $a2 ready to be passed into the subroutine
	li $a3, 0x0000FF00	# Load the colour (green) into the register 
	
	jal drawcircle		# Enter the subroutine "drawcircle"
	nop
		
 	j primitiveran
 	nop	 		
 		 			 			 		

runfillcircle:

	li $a0, 50			# Load the x co-ordinate of the centre point (50) into the register $a0 ready to
						# be passed into the subroutine
	li $a1, 50			# Load the y co-ordinate of the centre point (50) into the register $a1 ready to
						# be passed into the subroutine
	li $a2, 25			# Load the radius (25) into the register $a2 ready to be passed into the subroutine
	li $a3, 0x00FFFFFF	# Load the colour (white) into the register $a3 ready to be passed into the subroutine
	
	jal fillcircle		# Enter the subroutine "fillcircle"
	nop
	
	li $a0, 450			# Load the x co-ordinate of the centre point (450) into the register $a0 ready to
						# be passed into the subroutine
	li $a1, 200			# Load the y co-ordinate of the centre point (200) into the register $a1 ready to
						# be passed into the subroutine
	li $a2, 50			# Load the radius (50) into the register $a2 ready to be passed into the subroutine
	li $a3, 0x00FF00FF	# Load the colour (purple) into the register $a3 ready to be passed into the subroutine
	
	jal fillcircle		# Enter the subroutine "fillcircle"
	nop
	
	li $a0, 200			# Load the x co-ordinate of the centre point (200) into the register $a0 ready to
						# be passed into the subroutine
	li $a1, 150			# Load the y co-ordinate of the centre point (150) into the register $a1 ready to
						# be passed into the subroutine
	li $a2, 100			# Load the radius (100) into the register $a2 ready to be passed into the subroutine
	li $a3, 0x00FF0000	# Load the colour (red) into the register $a3 ready to be passed into the subroutine
	
	jal fillcircle		# Enter the subroutine "fillcircle"
	nop
	
	li $a0, 400			# Load the x co-ordinate of the centre point (400) into the register $a0 ready to 
						# be passed into the subroutine
	li $a1, 100			# Load the y co-ordinate of the centre point (100) into the register $a1 ready to 
						# be passed into the subroutine
	li $a2, 10			# Load the radius (10) into the register $a2 ready to be passed into the subroutine
	li $a3, 0x0000FF00	# Load the colour (green) into the register 
	
	jal fillcircle		# Enter the subroutine "fillcircle"
	nop
	
	j primitiveran
	nop

rundashedlines:

	# Demonstrates the drawdashedline function (int x1, int y1, int x2, int y2, int dash, int space, int colour)
	
	li $a0, 49			# Load the x co-ordinate (49) of point 1 into the register $a0 ready to 
						# be passed into the subroutine
    li $a1, 49			# Load the y co-ordinate (49) of point 1 into the register $a1 ready to 
						# be passed into the subroutine
    li $a2, 99			# Load the x co-ordinate (99) of point 2 into the register $a2 ready to 
						# be passed into the subroutine
    li $a3, 99			# Load the y co-ordinate (99) of point 2 into the register $a3 ready to 
						# be passed into the subroutine
    li $t9, 0x00FF0000	# Load the colour of the line (red) into $t9 so it can be added to the stack
    li $t8, 1			# Set the value of the dash length to 1
    li $t7, 4			# Set the value of the space between dashes to 4
	addiu $sp, $sp, -12	# Decrement the stack pointer
	sw $t7, 8($sp)		# Save the value of the dash length to the stack
	sw $t8, 4($sp)		# Save the value of the space between dashed to the stack
	sw $t9, ($sp)		# Save the colour to the stack
	
	jal drawdashedline	# Enter the subroutine "drawline"
	nop
	
	li $a0, 99			# Load the x co-ordinate (99) of point 1 into the register $a0 ready to 
						# be passed into the subroutine
	li $a1, 49			# Load the y co-ordinate (49) of point 1 into the register $a1 ready to 
						# be passed into the subroutine
	li $a2, 199			# Load the x co-ordinate (199) of point 2 into the register $a2 ready to 
						# be passed into the subroutine
	li $a3, 49			# Load the y co-ordinate (49) of point 2 into the register $a3 ready to 
						# be passed into the subroutine
	li $t9, 0x00FFFFFF	# Load the colour of the line (white) into $t9 so it can be added to the stack
	li $t8, 1			# Set the value of the dash length to 1
	li $t7, 1			# Set the value of the space between dashes to 1
	addiu $sp, $sp, -12	# Decrement the stack pointer
	sw $t7, 8($sp)		# Save the value of the dash length to the stack
	sw $t8, 4($sp)		# Save the value of the space between dashes to the stack
	sw $t9, ($sp)		# Save the value of the colour to the stack
	
	jal drawdashedline	# Enter the subroutine "drawline"
	nop
	
	li $a0, 200			# Load the x co-ordinate (200) of point 1 into the register $a0 ready to 
						# be passed into the subroutine
	li $a1, 200			# Load the y co-ordinate (200) of point 1 into the register $a1 ready to 
						# be passed into the subroutine
	li $a2, 200			# Load the x co-ordinate (200) of point 2 into the register $a2 ready to 
						# be passed into the subroutine
	li $a3, 100			# Load the y co-ordinate (100) of point 2 into the register $a3 ready to 
						# be passed into the subroutine
	li $t9, 0x00FFFFFF	# Load the colour of the line (white) into $t9 so it can be added to the stack
	li $t8, 4			# Set the value of the dash length to 4
	li $t7, 1			# Set the value of the space between dashes to 1
	addiu $sp, $sp, -12	# Decrement the stack pointer
	sw $t7, 8($sp)		# Save the value of the dash length to the stack
	sw $t8, 4($sp)		# Save the value of the space between dashes to the stack
	sw $t9, ($sp)		# Save the value of the colour to the stack
	
	jal drawdashedline	# Enter the subroutine "drawline"
	nop
	
	li $a0, 350			# Load the x co-ordinate (350) of point 1 into the register $a0 ready to 
						# be passed into the subroutine
	li $a1, 200			# Load the y co-ordinate (200) of point 1 into the register $a1 ready to 
						# be passed into the subroutine
	li $a2, 500			# Load the x co-ordinate (500) of point 2 into the register $a2 ready to 
						# be passed into the subroutine
	li $a3, 50			# Load the y co-ordinate (50) of point 2 into the register $a3 ready to 
						# be passed into the subroutine
	li $t9, 0x00FFFFFF	# Load the colour of the line (white) into $t9 so it can be added to the stack
	li $t8, 2			# Set the value of the dash length to 2
	li $t7, 2			# Set the value of the space between dashes to 2
	addiu $sp, $sp, -12	# Decrement the stack pointer
	sw $t7, 8($sp)		# Save the value of the dash length to the stack
	sw $t8, 4($sp)		# Save the value of the space between dashes to the stack
	sw $t9, ($sp)		# Save the value of the colour to the stack
	
	jal drawdashedline	# Enter the subroutine "drawline"
	nop
	
	j primitiveran		# Jumps back to the main when the subroutine is finished
	nop

      				      				      				      		      				      				      				      				
      	j primitiveran
      	nop
      	
      	# # # # # # # # # # All subroutines are written below # # # # # # # # # # # # # # # # # # # # # # 	
      			
      		
	# # # # # # # # # # SetPixel(int x, int y, int colour)  # # # # # # # # # # # # # # # # # # # # # 		
	#																								#
	# 																								#
	# Sets a pixel at the specified x and y co-ordinates [(0 - 511) and (0 - 255)] 					#
	# to the colour taken																			#
	# in, with the colour being defined by 0x00RRGGBB, with each byte being 						#
	# an individual value from 0-255 (in hex)														#
	#																								#
	#																								#
	# Register usage in subroutine:																	#
	#																								#
	# $s0 = X co-ordinate (between 0 - 511)															#
	#																								#
	# $s1 = Y co-ordinate (between 0 - 255)															#
	#																								#
	# $s2 = Colour of the pixel (0x00RRGGBB)														#
	#																								#
	# $s3 = Pixel address (between 0x10010000 and 0x1008FFFC)										#
	#																								#
	# $s4 = Reserved as a temporary variable in calculations of the pixel location					#
	#																								#
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #      
	    
setpixel:
																									
	# Stores the values of the s registers in the stack so they can be used in the subroutine
												
	addiu $sp, $sp, -24	# Decrement the stack pointer
	sw $ra, 20($sp)		# Save the value of the return address to the stack
	sw $s0, 16($sp)		# Save the original value of $s0 to the stack
	sw $s1, 12($sp)		# Save the original value of $s1 to the stack
	sw $s2, 8($sp)		# Save the original value of $s2 to the stack
	sw $s3, 4($sp)		# Save the original value of $s3 to the stack
	sw $s4, ($sp)		# Save the original value of $s4 to the stack
	
	
	# Copies the values of the parameters passed in into the now free s registers
	
	move $s0, $a0		# Store the x co-ordinate in $s0
	move $s1, $a1		# Store the y co-ordinate in $s1
	move $s2, $a2		# Store the colour in $s2
	li $s3, 0x10010000 	# Load the base address (Top left hand pixel (x = 0, y = 0) address = 0x10010000
		
				
	# The main code for drawing the pixel to the bitmap
			
	sll $s1, $s1, 9		# The shift of 9 turns the y co-ordinate into the bit value of it by raising 
						# the power of the y co-ordinate to 9
	addu $s4, $s0, $s1	# Adds x co-ordinate to the number of bits calculated by the Y co-ordinate and shift
	sll $s4, $s4, 2		# The shift of 2 moves moves the bit value along to put the x co-ordinate 
						# in the correct location
	addu $s3, $s3, $s4	# Adds the value of the of the shift calculated to the base address 
						# to reach the correct XY co-ordinates
	sw $s2, ($s3)		# Load the colour into the specified memory address location		
	
					
	# Restores the original values of the s registers from the stack						
					
	lw $s4, ($sp)		# Restore original value of $s4	from the stack
	lw $s3, 4($sp)		# Restore original value of $s3 from the stack
	lw $s2, 8($sp)		# Restore original value of $s2 from the stack
	lw $s1, 12($sp)		# Restore original value of $s1 from the stack
	lw $s0, 16($sp)		# Restore original value of $s0 from the stack
	lw $ra, 20($sp)		# Restore the value of the return address from the stack
	addiu $sp, $sp, 24	# Increment the stack pointer
	
	jr $ra		# Jump to the return address to exit the subroutine
	nop
	
	# # # # # # # # # End of the SetPixel subroutine # # # # # # # # # # # # # # 	
	
	
	# # # # # # # # # DrawLine(int x1, int y1, int x2, int y2, int colour)  # # # # # # # # # # # # #  
	#											 													#
	# 											 													#
	# Draws a line using "Bresenham's line drawing algorithm" between two points,		 			#
	# (x1, y1) and (x2, y2), and the line is the colour defined by 0x00RRGGBB, 		 				#
	# with each byte being an individual value from 0-255 (in hex)				 					#
	# Each pixel of the line is drawn using the SetPixel subroutine 			 					#
	#																								#
	#																								#
	# Registers used in the subroutine:																#
	#																								#
	# $s0 = X co-ordinate of point 1 (between 0 - 511)												#
	#																								#
	# $s1 = Y co-ordinate of point 1 (between 0 - 255)												#	
	#																								#
	# $s2 = X co-ordinate of point 2 (between 0 - 511)												#
	#																								#
	# $s3 = Y co-ordinate of point 2 (between 0 - 255)												#
	#																								#
	# $s4 = Colour of the line (0x00RRGGBB)															#
	#																								#
	# $s5 = Reserved for dx, used in calculations													#
	#																								#
	# $s6 = Reserved for dy, used in calculations													#
	#																								#
	# $s7 = Reserved for sx, used to determine if line is complete									#
	#																								#
	# $t0 = Reserved for sy, used to determine if line is complete									#
	#																								#
	# $t1 = Reserved for err, variable designated by Bresenham's line algorithm						#
	#																								#
	# $t2 = Reserved for e2, variable designated by Bresenham's line algorithm						#
	#																								#
	# $t3 = Temporary register, used for storing temporary values while calculating dx or dy		#
	#																								#
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
	
drawline:	
		
	# Stores the values of the s registers in the stack so they can be used in the subroutine
	
	addiu $sp, $sp, -52	# Decrement the stack pointer
	sw $ra, 48($sp)		# Save the value of the return address ($ra) to the stack
	sw $s0, 44($sp)		# Save the original value of $s0 to the stack
	sw $s1, 40($sp)		# Save the original value of $s1 to the stack
	sw $s2, 36($sp)		# Save the original value of $s2 to the stack
	sw $s3, 32($sp)		# Save the original value of $s3 to the stack
	sw $s4, 28($sp)		# Save the original value of $s4 to the stack
	sw $s5, 24($sp)		# Save the original value of $s5 to the stack
	sw $s6, 20($sp)		# Save the original value of $s6 to the stack
	sw $s7, 16($sp)		# Save the original value of $s7 to the stack
	sw $t0, 12($sp)		# Save the original value of $t0 to the stack
	sw $t1, 8($sp)		# Save the original value of $t1 to the stack
	sw $t2, 4($sp)		# Save the original value of $t2 to the stack
	sw $t3, ($sp)		# Save the original value of $t3 to the stack 
	
	# Copies the values of the parameters passed in into the now free s registers
	
	move $s0, $a0		# Store the x co-ordinate of point 1 in $s0
	move $s1, $a1		# Store the y co-ordinate of point 1 in $s1
	move $s2, $a2		# Store the x co-ordinate of point 2 in $s2
	move $s3, $a3		# Store the y co-ordinate of point 2 in $s3
	lw $s4, 52($sp)		# Store the colour (takes form the stack) in $s4
	
	
	# Main code for drawing the line on the bitmap
	
	subu $t3, $s2, $s0 		# Calculates x1 - x0 and store it in $t3
	abs $s5, $t3 			# Sets dx ($s5) to the absolute value of x1 - x0
	subu $t3, $s3, $s1		# Calculates y1 - y0 and stores it in $t3
	abs $s6, $t3			# Sets dy ($s6) to the absolute value of y1 - y0
	sub, $s6, $zero, $s6 	# Sets dy to -dy as dy is needed as a minus value later in calculations
							# it is turned minus via two's complement method
	bgt $s0, $s2, sxelse	# If x0 is greater than x1 then branch to sxelse
	nop
	li $s7, 1				# Set the value of sx ($s7) to 1
	b sxcomplete			# Branch around the sxelse section
	nop
	
sxelse:				# Branches to here if x0 is greater than x1
	li $s7, -1		# Sets the value of sx ($s7) to -1	

sxcomplete:					# Branches to here if x1 was greater than x0
	bgt $s1, $s3, syelse	# If y0 is greater than y1 then branch to syelse
	nop
	li $t0, 1				# Sets the value of sy ($t0) to 1 
	b sycomplete			# Branch around the syelse section
	nop
	
syelse:				# Branche shere is y0 is greater than y1
	li $t0, -1		# Sets the value sy ($t0) to -1
	
sycomplete:				# Branches to here if y1 was greater than y0
	addu $t1, $s5, $s6	# err is set to the value of dx - dy
	
drawpixelloop:
	move $a0, $s0		# Store the x co-ordinate in $a0
	move $a1, $s1		# Store the y co-ordinate in $a1
	move $a2, $s4		# Store the colour in $a2
	
	jal setpixel		# Enter the subroutine "setpixel"
	nop
	
	add $t2, $t1, $t1					# Sets e2 ($t2) to err ($t1) * 2 by calculating err + err   
	bgt $s6, $t2, e2notgreaterthandy	# Branch if -dy is greater than e2
	nop
	add $t1, $t1, $s6					# Calculate err = err - dy: err = $t1 , -dy = $s6
	add $s0, $s0, $s7					# Calculate x0 = x0 + sx: x0 = $s0 , sx = $s7
	
e2notgreaterthandy:	
	bgt $t2, $s5, e2greaterthandx		# Branch if e2 ($t2) is greater than dx ($s5)
	nop 
	add $t1, $t1, $s5					# Calculate err = derr + dx: err = $t1 , dx = $s5
	add $s1, $s1, $t0  					# Caluclate y0 = y0 + sy: y0 = $s1 , sy = $t0
e2greaterthandx:
	
	# To exit the loop x0 must now be equal to x1 and y0 much now be equal to y1
	# The two statements must be true to pass both branches and thus exits the loop
	
	bne $s0, $s2, drawpixelloop	# If x0 ($s0) and x1 ($s2) are not 
	nop							# equal branch to drawpixelloop
	bne $s1, $s3, drawpixelloop	# If y0 ($s1) and y1 ($s3) are not
	nop							# equal branch to drawpixelloop
	
	# Restores the original values of the s registers from the stack
	
	lw $t3, ($sp)		# Restore the original value of $t3 from the stack
	lw $t2, 4($sp)		# Restore the original value of $t2 from the stack
	lw $t1, 8($sp)		# Restore the original value of $t1 from the stack
	lw $t0, 12($sp)		# Restore the original value of $t0 from the stack
	lw $s7, 16($sp)		# Restore the original value of $s7 from the stack 
	lw $s6, 20($sp)		# Restore the original value of $s6 from the stack
	lw $s5, 24($sp)		# Restore the original value of $s5 from the stack
	lw $s4, 28($sp)		# Restore the original value of $s4 from the stack
	lw $s3, 32($sp)		# Restore the original value of $s3 from the stack
	lw $s2, 36($sp)		# Restore the original value of $s2 from the stack
	lw $s1, 40($sp)		# Restore the original value of $s1 from the stack
	lw $s0, 44($sp)		# Restore the original value of $s0 from the stack
	lw $ra, 48($sp)		# Restore the value of the return address ($ra) from the stack
	addiu $sp, $sp, 56	# Increment the stack pointer, taking itnto account the parameter pushed onto the stack
	
	jr $ra 		# Jump to the return address to exit the subroutine
	nop
	
	# # # # # # # # # End of the DrawLine subroutine # # # # # # # # # # # # # # # # # # # # # # # # 
	
	
	# # # # # # # # # DrawRectangle(int x, int y, int width, int height, int colour)  # # # # # # # #
	#																								#
	# 																								#
	# Draws a rectangle with the x and y parameters being the top left 								#
	# hand vertices of the rectangle.  																#
	# The width and height parameters are then used to calculate the other 							#
	# 3 vertices of the rectangle.																	#
	# The DrawLine method is then called to draw the 4 sides of the rectangle, 						#
	# using the colour paramter taken in as the colour for the sides of the rectangle				#
	# 																								#
	#																								#
	# 			The rectangle is drawn in the form:													#
	#																								#
	# 			Vertex 1 ------------ Vertex 2														#
	# 			   |			   |																#
	# 			Vertex 4 ------------ Vertex 3														#
	#																								#
	# Line one   = Vertex 1 to Vertex 2																#
	# Line two   = Vertex 2 to Vertex 3																#
	# Line three = Vertex 3 to Vertex 4																#
	# Line four  = Vertex 4 to Vertex 1																#
	#																								#
	# Registers used in the subroutine:																#
	# $s0 = X co-ordinate of the first vertex (between 0 - 511), will also then have its 			#
	# values changed to be used for other lines that make up the rectangle							#
	# 																								#
	# $s1 = Y co-ordinate of the first vertex (between 0 - 255), will also then have its 			#
	# values changed to be used for other lines that make up the rectangle							#
	# 																								#		
	# $s2 = Width of the rectangle (between 0 - 511)												#
	#																								#
	# $s3 = Height of the rectangle (between 0 - 255)												#
	#																								#
	# $s4 = Colour of the outline of the rectangle (0x00RRGGBB)										#
	#																								#
	# $s5 = X co-ordinate of the second vertex (between 0 - 511) to be used for 					#
	# drawing the sides of the rectangle															#	
	#																								#
	# $s6 = Y co-ordinate of the second vertex (between 0 - 255) to be used for 					#
	# drawing the sides of the rectangle 															#	
	#																								#
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	
drawrectangle:		# Enter the DrawRectangle subroutine
	
	# Stores the values of the s registers in the stack so they can be used in the subroutine
	
	addiu $sp, $sp, -32	# Decrement the stack pointer
	sw $ra, 28($sp)		# Save the value of the return address ($ra) to the stack
	sw $s0, 24($sp)		# Save the original value of $s0 to the stack
	sw $s1, 20($sp)		# Save the original value of $s1 to the stack
	sw $s2, 16($sp)		# Save the original value of $s2 to the stack
	sw $s3, 12($sp)		# Save the original value of $s3 to the stack
	sw $s4, 8($sp)		# Save the original value of $s4 to the stack
	sw $s5, 4($sp)		# Save the original value of $s5 to the stack
	sw $s6, ($sp)		# Save the original value of $s6 to the stack
	
	
	# Copies the values of the parameters passed in into the now free s registers
	
	move $s0, $a0		# Store the x co-ordinate of the first vertex in $s0
	move $s1, $a1		# Store the y co-ordinate of the first vertex in $s1
	move $s2, $a2		# Store the width of the rectangle in $s2
	move $s3, $a3		# Store the height of the rectangle in $s3
	lw $s4, 32($sp)		# Store the colour (takes form the stack) in $s4
	
	
	# Main code for drawing the rectangle
	
	# Code to draw the first side of the rectangle:
	#
	# Vertex 1 ---------- Vertex 2
	# ($s0,$s1)	      ($s5,$s6)
	#
	# Vertex 1 ($s0,$s1) is already set from the original parameters
	
	
	add $s5, $s0, $s2	# Set the x co-ordinate of the vertex 2 to the x co-ordinate 
						# of vertex 1 + the width 
	add $s6, $s1, $zero	# Set the y co-ordinate of the vertex 2 to the y co-ordinate
						# of vertex 1 
	
	la $a0, ($s0)		# Load the x co-ordinate of vertex 1 into the x co-ordinate 
						# of point 1 of the line 
	la $a1, ($s1)		# Load the y co-ordinate of vertex 1 into the y co-ordinate
						# of point 1 of the line 
	la $a2, ($s5)		# Load the x co-ordinate of vertex 2 into the x co-ordinate
						# of point 2 of the line 
	la $a3, ($s6)		# Load the y co-ordinate of vertex 2 into the y co-ordinate
						# of point 2 of the line 
	la $t9, ($s4)		# Load the colour of the line into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack
	
	jal drawline		# Enter the subroutine "drawline"
	nop
	
	# Code to draw the second side of the rectangle
	#
	# Vertex 2 ($s5,$s6)
	#    |
	# Vertex 3 ($s0, $s1)
	#
	# Vertex 2 ($s5,$s6) is already set from the previous line calculation
	
	add $s0, $s0, $s2	# Set the x co-ordinate of the vertex 3 to the x co-ordinate 
				# of vertex 1 + the width	
	add $s1, $s1, $s3	# Set the y co-ordinate of the vertex 3 to the y co-ordinate 
				# of vertex 1 + the height
	
	la $a0, ($s5)		# Load the x co-ordinate of vertex 2 into the x co-ordinate 
						# of point 1 of the line 
	la $a1, ($s6)		# Load the y co-ordinate of vertex 2 into the y co-ordinate 
						# of point 1 of the line 
	la $a2, ($s0)		# Load the x co-ordinate of vertex 3 into the x co-ordinate 
						# of point 1 of the line  
	la $a3, ($s1)		# Load the y co-ordinate of vertex 3 into the y co-ordinate 
						# of point 1 of the line  
	la $t9, ($s4)		# Load the colour of the line into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack
	
	jal drawline		# Enter the subroutine "drawline"
	nop
	
	# Code to draw the third side of the rectangle
	#
	# Vertex 4 ---------- Vertex 3
	# ($s5,$s6)	      ($s0,$s1)
	#
	# Vertex 3 ($s0,$s1) is already set from the previous line calculation
	
	sub $s5, $s5, $s2	# Set the x co-ordinate of the vertex 4 to the x co-ordinate 
				# of vertex 2 - the width 
	add $s6, $s6, $s3	# Set the y co-ordinate of the vertex 4 to the y co-ordinate 
				# of vertex 2 + the height
	
	la $a0, ($s0)		# Load the x co-ordinate of vertex 3 into the x co-ordinate 
						# of point 1 of the line 
	la $a1, ($s1)		# Load the y co-ordinate of vertex 3 into the x co-ordinate 
						# of point 1 of the line 
	la $a2, ($s5)		# Load the x co-ordinate of vertex 4 into the x co-ordinate 
						# of point 1 of the line 
	la $a3, ($s6)		# Load the y co-ordinate of vertex 4 into the x co-ordinate 
						# of point 1 of the line 
	la $t9, ($s4)		# Load the colour of the line into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack
	
	jal drawline		# Enter the subroutine "drawline"
	nop
	
	# Code the draw the fourth side of the rectangle
	
	sub $s0, $s0, $s2	# Set the x co-ordinate of the vertex 1 to the x co-ordinate 
				# of vertex 3 - the width
	sub $s1, $s1, $s3	# Set the y co-ordinate of the vertex 1 to the y co-ordinate 
				# of vertex 3 - the height

	la $a0, ($s5)		# Load the x co-ordinate of vertex 4 into the x co-ordinate 
						# of point 1 of the line  
	la $a1, ($s6)		# Load the y co-ordinate of vertex 4 into the x co-ordinate 
						# of point 1 of the line  
	la $a2, ($s0)		# Load the x co-ordinate of vertex 1 into the x co-ordinate 
						# of point 1 of the line 
	la $a3, ($s1)		# Load the y co-ordinate of vertex 1 into the x co-ordinate 
						# of point 1 of the line  
	la $t9, ($s4)		# Load the colour of the line into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack
	
	jal drawline		# Enter the subroutine "drawline"
	nop
	
	
	# Restores the original values of the s registers from the stack
	
	lw $s6, ($sp)		# Restore the original value of $s6 from the stack
	lw $s5, 4($sp)		# Restore the original value of $s5 from the stack
	lw $s4, 8($sp)		# Restore the original value of $s4 from the stack
	lw $s3, 12($sp)		# Restore the original value of $s3 from the stack
	lw $s2, 16($sp)		# Restore the original value of $s2 from the stack
	lw $s1, 20($sp)		# Restore the original value of $s1 from the stack
	lw $s0, 24($sp)		# Restore the original value of $s0 from the stack
	lw $ra, 28($sp)		# Restore the value of the return address ($ra) from the stack
	addiu $sp, $sp, 36	# Increment the stack pointer, taking itnto account the parameter pushed onto the stack
	
	jr $ra		# Jump to the return address to exit the subroutine
	nop
	
	# # # # # # # # # End of the DrawRectangle subroutine # # # # # # # # # # # # # # #
	
	
	# # # # # # # # # # DrawPolygon(point[] points, int count, int colour)  # # # # # # # # # # # # # 		
    #																								#
	# 																								#
	# Draws a polygon with the number of side equal to the parameter count, which is used			#
	# to count the number of sides being drawn. The point of the line which are stored in array 	#
	# are structs in the form: 																		#
	# 																								#
	#	struct point																				#
	#	{																							#
	#	   int x																					#
	#	   int y																					#
	#	}																							#
	#																								#
	# Register usage in subroutine:																	#
	#																								#
	# $s0 = X co-ordinate of point 1 (between 0 - 511)												#
	#																								#
	# $s1 = Y co-ordinate of point 1(between 0 - 255)												#
	#																								#
	# $s2 = X co-ordinate of point 2 (between 0 - 511)												#
	#																								#
	# $s3 = Y co-ordinate of point 2(between 0 - 255)												#
	#																								#
	# $s4 = The count of the polygon (or the number of sides)										#
	#																								#
	# $s5 = Colour of the pixel (0x00RRGGBB)														#
	#																								#
	# $s6 = The current count of the polygon (to be compared to the original count					#
	#																								#
	# $s7 = The address of the start of the array													#
	#																								#
	#																								#
	# $t0 = The address of the array element wanted													#
	#																								#
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
	
drawpolygon:	 	 	
	
	# Stores the values of the s registers in the stack so they can be used in the subroutine
												
	addiu $sp, $sp, -40	# Decrement the stack pointer
	sw $ra, 36($sp)		# Save the returna ddress to the stack
	sw $s0, 32($sp)		# Save the original value of $s0 to the stack
	sw $s1, 28($sp)		# Save the original value of $s1 to the stack
	sw $s2, 24($sp)		# Save the original value of $s2 to the stack
	sw $s3, 20($sp)		# Save the original value of $s3 to the stack
	sw $s4, 16($sp)		# Save the original value of $s4 to the stack
	sw $s5, 12($sp)		# Save the original value of $s5 to the stack
	sw $s6, 8($sp)		# Save the original value of $s6 to the stack
	sw $s7, 4($sp)		# Save the original value of $s7 to the stack
	sw $t0, ($sp)		# Save the original value of $t0 to the stack
	
	
	# Copies the values of the parameters passed in into the now free s registers $s1
	
	move $s4, $a1		# Store the count (number of sides) of the polygon into $s0
	
	move $s5, $a2		# Store the the colour into $s1
	la $s7, ($a0)		# Store the address of the array in $s7
	li $s6, 0			# Start the count at 0

	add $s4, $s4, -1	# Set the count to 1 less than its value for comparison to the other count
	
	
drawsidesloop:	# Draw all sides apart from the last of the polygon using the drawline subroutine:
						# Get the value of x1 of the line from the array
	mul $t0, $s6, 8		# Multiply the count by the size of the struct (8 bytes)
	add $t0, $t0, $s7	# Add the value to the base address
	lw $s0, ($t0)		# Load the value into the x1 register ($s0)
	
						# Get the value of y1 of the line from the array
	mul $t0, $s6, 8		# Multiply the count by the size of the struct (8 bytes)		
	add $t0, $t0, 4		# Add four to access the second element of the struct
	add $t0, $t0, $s7	# Add the value to the base address
	lw $s1, ($t0)		# Load the value into the y1 register ($s1)
	
						# Get the value of x2 of the line from the array
	add $t0, $s6, 1		# Multiply the count + 1 
	mul $t0, $t0, 8		# by the size of the struct (8 bytes)
	add $t0, $t0, $s7	# Add the value to the base address
	lw $s2, ($t0)		# Load the value into the x2 register ($s2)

						# Get the value of y2 of the line from the array
	add $t0, $s6, 1		# Multiply the count +1
	mul $t0, $t0, 8		# by the size of the struct (8 bytes)
	add $t0, $t0, 4		# Add four to access the second element of the struct
	add $t0, $t0, $s7	# Load the value into the y2 register ($s3)
	lw $s3, ($t0)
	
	la $a0, ($s0)		# Load the x co-ordinate (stored in $s0) of point 1 into the register $a0 ready to 
						# be passed into the subroutine		
	la $a1, ($s1)		# Load the y co-ordinate (stored in $s1) of point 1 into the register $a0 ready to 
						# be passed into the subroutine
	la $a2, ($s2)		# Load the x co-ordinate (stored in $s2) of point 2 into the register $a0 ready to 
						# be passed into the subroutine
	la $a3, ($s3)		# Load the y co-ordinate (stored in $s3) of point 2 into the register $a0 ready to 
						# be passed into the subroutine
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $s5, ($sp)		# Save the value of $s5 (the colour paramter) to the stack
	jal drawline		# Enter the subroutine "drawline"
	nop
	
	add $s6, $s6, 1				# Increment the count
	bne $s4, $s6, drawsidesloop	# If the counts are not equal, loop again
	nop
	
lastside:	# Draw the final side of the polygon using the drawline subroutine
	mul $t0, $s6, 8		# Multiply the count by the size of the struct (8 bytes)
	add $t0, $t0, $s7	# Add the value to the base address
	lw $s0, ($t0)		# Load the value into the x1 register ($s0) 

	mul $t0, $s6, 8		# Multiply the count by the size of the struct (8 bytes)
	add $t0, $t0, 4		# Add four to access the second element of the struct
	add $t0, $t0, $s7	# Add the value to the base address
	lw $s1, ($t0)		# Load the value into the y1 register ($s1)
	
	move $t0, $s7		# Set $t0 to the base address, since the first struct is being accessed
	lw $s2, ($t0)		# Load the value into the x2 register ($s2) 
	
	add $t0, $zero, 4	# Set the value to four, to access to the second element of the struct
	add $t0, $t0, $s7	# Add it to the base address, since the first struct is being accessed
	lw $s3, ($t0)		# Load the value into the y2 register ($s3)
	
	la $a0, ($s0)		# Load the x co-ordinate (stored in $s0) of point 1 into the register $a0 ready to 
						# be passed into the subroutine	 
	la $a1, ($s1)		# Load the y co-ordinate (stored in $s1) of point 1 into the register $a0 ready to 
						# be passed into the subroutine	
	la $a2, ($s2)		# Load the x co-ordinate (stored in $s2) of point 2 into the register $a0 ready to 
						# be passed into the subroutine	
	la $a3, ($s3)		# Load the y co-ordinate (stored in $s3) of point 2 into the register $a0 ready to 
						# be passed into the subroutine	
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $s5, ($sp)		# Save the value of $s5 (the colour paramter) to the stack
	jal drawline		# Enter the subroutine "drawline"
	nop
	
	
	# Restores the original values of the s registers from the stack						
	
	lw $t0, ($sp)		# Restore original value of $t0 from the stack
	lw $s7, 4($sp)		# Restore original value of $s7 from the stack
	lw $s6, 8($sp)		# Restore original value of $s6 from the stack
	lw $s5, 12($sp)		# Restore original value of $s5 from the stack
	lw $s4, 16($sp)		# Restore original value of $s4	from the stack
	lw $s3, 20($sp)		# Restore original value of $s3 from the stack
	lw $s2, 24($sp)		# Restore original value of $s2 from the stack
	lw $s1, 28($sp)		# Restore original value of $s1 from the stack
	lw $s0, 32($sp)		# Restore original value of $s0 from the stack
	lw $ra, 36($sp)		# Restore the return address from the stack
	addiu $sp, $sp, 24	# Increment the stack pointer
	
	jr $ra		# Jump to the return address to exit the subroutine
	nop		
	
	# # # # # # # # # # # End of the DrawPolygon Subroutine # # # # # # # # # # # # # # # # # # # # # # # 
	
	
	# # # # # # # # # FillRectangle(int x, int y, int width, int height, int colour)  # # # # # # # #
	#																								#
	# 																								#
	# Fill a rectangle with a solid colour with the x and y parameters being the top left 			#
	# hand vertices of the rectangle.  																#
	# The rectangle is filled by drawing another line every time the y vertices is increased by one	#
	# until it has been increased enough times to equal the height.									#
	# The colour paramter taken in is used as the colour of the rectangle							#
	# 																								#
	#																								#
	# 			The rectangle is drawn in the form:													#
	#																								#
	# 			Vertex 1 ------------ Vertex 2														#
	# 			   |			   |																#
	# 			Vertex 4 ------------ Vertex 3														#
	#																								#
	# Line one   = Vertex 1 to Vertex 2																#
	# Line two   = Vertex 2 to Vertex 3																#
	# Line three = Vertex 3 to Vertex 4																#
	# Line four  = Vertex 4 to Vertex 1																#
	#																								#
	# Registers used in the subroutine:																#
	# $s0 = X co-ordinate of the first vertex (between 0 - 511)(x co-ordinate of the rectangle + 1) # 					
	# 																								#
	# $s1 = Y co-ordinate of the first vertex (between 0 - 255), will also then have its 			#
	# values changed to draw the lines to fill the rectangle, also used as the y co-ordinate		#
	# of the second vertex (since the lines are being drawn parralel to the edges of the bitmap		#
	# 																								#
	# $s2 = Width of the rectangle (between 0 - 511)												#
	#																								#
	# $s3 = Height of the rectangle (between 0 - 255)												#
	#																								#
	# $s4 = Colour of the outline of the rectangle (0x00RRGGBB)										#
	#																								#
	# $s5 = X co-ordinate of the second vertex (between 0 - 511), to draw the lines that 			#
	# fill the rectangle (x co-ordinate of the first vertex + width - 1)							#
	#																								#
	# $s6 = Y co-ordinate of the bottom line to be filled (between 0 - 255)  						#
	#																								#
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	
fillrectangle:	# Enter the FillRectangle Subroutine	
	
	# Stores the values of the s registers in the stack so they can be used in the subroutine
	
	addiu $sp, $sp, -32	# Decrement the stack pointer
	sw $ra, 28($sp)		# Save the value of the return address ($ra) to the stack
	sw $s0, 24($sp)		# Save the original value of $s0 to the stack
	sw $s1, 20($sp)		# Save the original value of $s1 to the stack
	sw $s2, 16($sp)		# Save the original value of $s2 to the stack
	sw $s3, 12($sp)		# Save the original value of $s3 to the stack
	sw $s4, 8($sp)		# Save the original value of $s4 to the stack
	sw $s5, 4($sp)		# Save the original value of $s5 to the stack
	sw $s6, ($sp)		# Save the original value of $s6 to the stack
	
	
	# Copies the values of the parameters passed in into the now free s registers
	
	move $s0, $a0		# Store the x co-ordinate of the first vertex in $s0
	move $s1, $a1		# Store the y co-ordinate of the first vertex in $s1
	move $s2, $a2		# Store the width of the rectangle in $s2
	move $s3, $a3		# Store the height of the rectangle in $s3
	lw $s4, 32($sp)		# Store the colour (takes form the stack) in $s4
	
	add $s0, $s0, 1		# Adds 1 to the x co-ordinate of vertex 1 
						# (as the outline of the rectangle is already drawn)
	add $s5, $s0, $s2	# Sets the x co-ordinate of vertex two to the value of vertex 1 x + width
	add $s5, $s5, -1	# Subtracts 1 from the x c0-ordinate of vertex 2 
						# (as the outine of the rectangle is already drawn) 
	add $s6, $s1, $s3	# Set the y co-ordinate of the bottom lien to be filled to
	add $s6, $s6, -1	# the y co-ordinate of vertex 1 + height - 1

	
drawlinesloop:			# Loops to draw lines to fill the rectangle
	
	add $s1, $s1, 1		# Increment the y co-ordinate of the line to be drawn by 1
	
	la $a0, ($s0)		# Load the x co-ordinate of vertex 1 into the x co-ordinate 
						# of point 1 of the line 
	la $a1, ($s1)		# Load the y co-ordinate of vertex 1 into the y co-ordinate
						# of point 1 of the line 
	la $a2, ($s5)		# Load the x co-ordinate of vertex 2 into the x co-ordinate
						# of point 2 of the line 
	la $a3, ($s1)		# Load the y co-ordinate of vertex 2 (the same as vertex 1) into the y co-ordinate
						# of point 2 of the line 
	la $t0, ($s4)		# Load the colour of the line (green) into $t0 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t0, ($sp)		# Save the value of $t0 (which is now the value of the colour paramter) to the stack
	
	jal drawline		# Enter the subroutine "drawline"
	nop
	
	bne $s1, $s6, drawlinesloop 	# If the y co-ordinate of the line just drawn is not equal to the bottom 
	nop								# most line needed to be drawn loop again
	
	# Restores the original values of the s registers from the stack
	
	lw $s6, ($sp)		# Restore the original value of $s6 from the stack
	lw $s5, 4($sp)		# Restore the original value of $s5 from the stack
	lw $s4, 8($sp)		# Restore the original value of $s4 from the stack
	lw $s3, 12($sp)		# Restore the original value of $s3 from the stack
	lw $s2, 16($sp)		# Restore the original value of $s2 from the stack
	lw $s1, 20($sp)		# Restore the original value of $s1 from the stack
	lw $s0, 24($sp)		# Restore the original value of $s0 from the stack
	lw $ra, 28($sp)		# Restore the value of the return address ($ra) from the stack
	addiu $sp, $sp, 36	# Increment the stack pointer, taking itnto account the parameter pushed onto the stack
	
	jr $ra		# Jump to the return address to exit the subroutine
	nop
	
	# # # # # # # # End of the FillRectangle Subroutine # # # # # # # # # # # # # # # # # # 
	
	
	# # # # # # # # # DrawCircle(int cx, int cy, int radius, int colour)  # # # # # # # # # # # # # #  
	#											 													#
	# 											 													#
	# Draws a circle using the midpoint circle algorithm, cx and cy are the co-ordinates of			#
	# of the centre of the circle, the radius is the distance from the centre to the perimeter, 	#
	# the colour parameter is the colour of the outline of the circle 								#
	# Each pixel of the line is drawn using the SetPixel subroutine 			 					#
	#																								#
	# Registers used in the subroutine:																#
	#																								#
	# $s0 = cx co-ordinate (between 0 - 511)														#
	#																								#
	# $s1 = cy co-ordinate (between 0 - 255)														#
	#																								#
	# $s2 = Radius of the circle (between 0 - 511)													#
	#																								#
	# $s3 = Colour of the line (0x00RRGGBB)															#
	#																								#
	# $s4 = Reserved for x, variable designated by midpoint circle algorithm						#
	#																								#
	# $s5 = Reserved for y, variable designated by midpoint circle algorithm						#
	#																								#
	# $s6 = Reserved for err, variable designated by midpoint circle algorithm						#
	#																								#
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	
drawcircle:	# Enter the draw circle subroutine

	# Stores the values of the s registers in the stack so they can be used in the subroutine
	
	addiu $sp, $sp, -32	# Decrement the stack pointer
	sw $ra, 28($sp)		# Save the value of the return address ($ra) to the stack
	sw $s0, 24($sp)		# Save the original value of $s0 to the stack
	sw $s1, 20($sp)		# Save the original value of $s1 to the stack
	sw $s2, 16($sp)		# Save the original value of $s2 to the stack
	sw $s3, 12($sp)		# Save the original value of $s3 to the stack
	sw $s4, 8($sp)		# Save the original value of $s4 to the stack
	sw $s5, 4($sp)		# Save the original value of $s5 to the stack
	sw $s6, ($sp)		# Save the original value of $s6 to the stack
	
	
	# Copies the values of the parameters passed in into the now free s registers
	
	move $s0, $a0		# Store the cx co-ordinate in $s0
	move $s1, $a1		# Store the cy co-ordinate  in $s1
	move $s2, $a2		# Store the radius of the circle in $s2
	move $s3, $a3		# Store colour of the circle in $s3
	
	sub $s6, $zero, $s2	# Set err to the value of -radius
	add $s4, $zero, $s2	# Set x to the value of radius
	add $s5, $zero, 0	# Set y to the 0

xgreaterequalthany:		# Loops back if x is greater or equal than y
	
	la $a0, ($s0)		# Load cx into the register $a0
	la $a1, ($s1)		# Load cy into the register $a1
	la $a2, ($s4)		# Load x into the register $a2
	la $a3, ($s5)		# Load y into the register $a3
	la $t0, ($s3)		# Load the colour into $t0 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t0, ($sp)		# Save the value of $t0 (which is nwo the value of the colour paramter) to the stack
	
	jal plot8points		# Enter the subroutine "plot8points"
	nop
	
	add $s6, $s6, $s5	# Calculate "error += y"
	add $s5, $s5, 1		# Calculate "++y"
	add $s6, $s6, $s5	# Calculate "error += y"
	
	bltz $s6, errlessthan0	# branch if err is less than zero
	nop
	
	sub $s4, $s4, 1		# Calculate "--x"
	sub $s6, $s6, $s4	# Calculate "error -= x"
	sub $s6, $s6, $s4	# Calculate "error -= x"
	
errlessthan0:	

	bge $s4, $s5 xgreaterequalthany		# Branches if x is greater or equal to y
	nop
	
	# Restores the original values of the s registers from the stack
	
	lw $s6, ($sp)		# Restore the original value of $s6 from the stack
	lw $s5, 4($sp)		# Restore the original value of $s5 from the stack
	lw $s4, 8($sp)		# Restore the original value of $s4 from the stack
	lw $s3, 12($sp)		# Restore the original value of $s3 from the stack
	lw $s2, 16($sp)		# Restore the original value of $s2 from the stack
	lw $s1, 20($sp)		# Restore the original value of $s1 from the stack
	lw $s0, 24($sp)		# Restore the original value of $s0 from the stack
	lw $ra, 28($sp)		# Restore the value of the return address ($ra) from the stack
	addiu $sp, $sp, 32	# Increment the stack pointer
	
	jr $ra		# Jump to the return address to exit the subroutine
	nop
	
			
plot8points:	# Subroutine that is part of the drawcircle subroutine

	# Stores the values of the s registers in the stack so they can be used in the subroutine
	
	addiu $sp, $sp, -24	# Decrement the stack pointer
	sw $ra, 20($sp)		# Save the value of the return address ($ra) to the stack
	sw $s0, 16($sp)		# Save the original value of $s0 to the stack
	sw $s1, 12($sp)		# Save the original value of $s1 to the stack
	sw $s2, 8($sp)		# Save the original value of $s2 to the stack
	sw $s3, 4($sp)		# Save the original value of $s3 to the stack
	sw $s4, ($sp)		# Save the original value of $s4 to the stack
	
	# Register Usage:
	# $s0 = cx
	# $s1 = cy
	# $s2 = x
	# $s3 = y
	# $s4 = colour
	
	# Copies the values of the parameters passed in into the now free s registers
	
	move $s0, $a0		# Store the cx co-ordinate in $s0
	move $s1, $a1		# Store the cy co-ordinate  in $s1
	move $s2, $a2		# Store x in $s2
	move $s3, $a3		# Store y in $s3
	lw $s4, 24($sp)		# Store the colour (takes form the stack) in $s4
	
	
	la $a0, ($s0)		# Load cx into the $a0 register
	la $a1, ($s1)		# Load cy into the $a1 register
	la $a2, ($s2)		# Load x into the $a2 register
	la $a3, ($s3)		# Load y into the $a3 register
	la $t0, ($s4)		# Load the colour into $t0 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t0, ($sp)		# Save the value of $t0 (which is nwo the value of the colour paramter) to the stack
	
	jal plot4points		# Enter the subroutine "plot4points"
	nop
	
	beq $s2, $s3, xequalsy	# Branch if x and y are equal 
	nop 
	
	la $a0, ($s0)		# Load cx into the $a0 register
	la $a1, ($s1)		# Load cy into the $a1 register
	la $a2, ($s3)		# Load y into the $a2 register
	la $a3, ($s2)		# Load x into the $a3 register
	la $t0, ($s4)		# Load the colour of the line (green) into $t0 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t0, ($sp)		# Save the value of $t0 (which is nwo the value of the colour paramter) to the stack
	
	jal plot4points		# Enter the subroutine "plot4points"
	nop
		
xequalsy:			# Jumps to here if x and y are equal

	# Restores the original values of the s registers from the stack

	lw $s4, ($sp)		# Restore the original value of $s4 from the stack
	lw $s3, 4($sp)		# Restore the original value of $s3 from the stack
	lw $s2, 8($sp)		# Restore the original value of $s2 from the stack
	lw $s1, 12($sp)		# Restore the original value of $s1 from the stack
	lw $s0, 16($sp)		# Restore the original value of $s0 from the stack
	lw $ra, 20($sp)		# Restore the value of the return address ($ra) from the stack
	addiu $sp, $sp, 28	# Increment the stack pointer, taking itnto account the parameter pushed onto the stack

	jr $ra
	nop	
	
	
plot4points:	# Subroutine that is part of the drawcircle subroutine

	# Stores the values of the s registers in the stack so they can be used in the subroutine
	
	addiu $sp, $sp, -32	# Decrement the stack pointer
	sw $ra, 28($sp)		# Save the value of the return address ($ra) to the stack
	sw $s0, 24($sp)		# Save the original value of $s0 to the stack
	sw $s1, 20($sp)		# Save the original value of $s1 to the stack
	sw $s2, 16($sp)		# Save the original value of $s2 to the stack
	sw $s3, 12($sp)		# Save the original value of $s3 to the stack
	sw $s4, 8($sp)		# Save the original value of $s4 to the stack
	sw $s5, 4($sp)		# Save the original value of $s5 to the stack
	sw $s6, ($sp)		# Save the original value of $s6 to the stack
	
	# Register Usage:
	# $s0 = cx
	# $s1 = cy
	# $s2 = x
	# $s3 = y
	# $s4 = colour
	# $s5 = tempX
	# $s6 = tempY
	
	# Copies the values of the parameters passed in into the now free s registers
	
	move $s0, $a0		# Store the cx co-ordinate in $s0
	move $s1, $a1		# Store the cy co-ordinate  in $s1
	move $s2, $a2		# Store x in $s2
	move $s3, $a3		# Store y in $s3
	lw $s4, 32($sp)		# Store the colour (takes form the stack) in $s4
	
	add $s5, $s0, $s2	# Set tempX to cx + x
	add $s6, $s1, $s3	# Set tempY to cy + y
	
	la $a0, ($s5)		# Load tempX into the $a0 register (cx + x)
	la $a1, ($s6)		# Load tempY into the $a1 register (cy + y)
	la $a2, ($s4)		# Load the colour into the $a2 register
	
	jal setpixel		# Enter the subroutine "setpixel"
	nop
	
	beqz $s2, xiszero	# Branch if x is equal to zero
	nop
	
	sub $s5, $s0, $s2	# Set tempX to cx - x
	
	la $a0, ($s5)		# Load tempX into the $a0 register (cx - x)
	la $a1, ($s6)		# Load tempY into the $a1 register (cy + y)
	la $a2, ($s4)		# Load the colour into the $a2 register
	
	jal setpixel		# Enter the Subroutine "setpixel"
	nop
	
xiszero:			# Branches here if x equals zero

	sub $s6, $s1, $s3	# Set tempY to cy - y
	
	la $a0, ($s5)		# Load tempX into the $a0 register (cx - x)
	la $a1, ($s6)		# Load tempY into the $a1 register (cy - y)
	la $a2, ($s4)		# Load the colour into the $a2 register
	
	jal setpixel		# Enter the Subroutine "setpixel"
	nop

	beqz $s3, yiszero	# Branch if y is equal to zero
	nop

	add $s5, $s0, $s2	# Set tempX to cx + x
	
	la $a0, ($s5)		# Load tempX into the $a0 register (cx + x)
	la $a1, ($s6)		# Load tempY into the $a1 register (cy - y)
	la $a2, ($s4)		# Load the colour into the $a2 register
	
	jal setpixel		# Enter the Subroutine "setpixel"
	nop

yiszero:			# Branches here if y equals zero
	
	# Restores the original values of the s registers from the stack
	
	lw $s6, ($sp)		# Restore the original value of $s6 from the stack
	lw $s5, 4($sp)		# Restore the original value of $s5 from the stack
	lw $s4, 8($sp)		# Restore the original value of $s4 from the stack
	lw $s3, 12($sp)		# Restore the original value of $s3 from the stack
	lw $s2, 16($sp)		# Restore the original value of $s2 from the stack
	lw $s1, 20($sp)		# Restore the original value of $s1 from the stack
	lw $s0, 24($sp)		# Restore the original value of $s0 from the stack
	lw $ra, 28($sp)		# Restore the value of the return address ($ra) from the stack
	addiu $sp, $sp, 36	# Increment the stack pointer, taking itnto account the parameter pushed onto the stack


	jr $ra			# Jump to the return address to exit the subroutine
	nop	
	
	# # # # # # # # End of the DrawCircle Subroutine # # # # # # # # # # # # # # # # # # 
	
	
	# # # # # # # # # FillCircle(int cx, int cy, int radius, int colour)  # # # # # # # # # # # # # #  
	#											 													#
	# 											 													#	 
	# Fills a circle by using an adapted  midpoint circle algorithm, which calls the drawline		#
	# function instead of the setpixel function.													#
	# cx and cy are the co-ordinates of the centre of the circle, the radius is the distance from 	#
	# the centre to the perimeter, the colour parameter is the colour of the circle 				#
	#																								#
	# Registers used in the subroutine:																#
	#																								#
	# $s0 = cx co-ordinate (between 0 - 511)														#
	#																								#
	# $s1 = cy co-ordinate (between 0 - 255)														#
	#																								#
	# $s2 = Radius of the circle (between 0 - 511)													#
	#																								#
	# $s3 = Colour of the line (0x00RRGGBB)															#
	#																								#
	# $s4 = Reserved for f, designated by midpoitn circle algorithm									#
	#																								#
	# $s5 = Reserved for ddF_x, designated by midpoint circle algorithm								#
	#																								#
	# $s6 = Reserved for ddF_y, variable designated by midpoint circle algorithm					#
	#																								#
	# $s7 = Reserved for x, variable designated by midpoint circle algorithm						#
	#																								#
	# $t0 = Reserved for y, variable designated by midpoint circle algorithm						#
	# 																								#
	# $t1 = Reserved for x1, variable to be used in the drawline call								#
	#																								#
	# $t2 = Reserved for y1, variable to be used in the drawline call								#
	#																								#
	# $t3 = Reserved for x2, variable to be used in the drawline call								#
	#																								#
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	
	
fillcircle:

	addiu $sp, $sp, -52	# Decrement the stack pointer
	sw $ra, 48($sp)		# Save the value of the return address ($ra) to the stack
	sw $s0, 44($sp)		# Save the original value of $s0 to the stack
	sw $s1, 40($sp)		# Save the original value of $s1 to the stack
	sw $s2, 36($sp)		# Save the original value of $s2 to the stack
	sw $s3, 32($sp)		# Save the original value of $s3 to the stack
	sw $s4, 28($sp)		# Save the original value of $s4 to the stack
	sw $s5, 24($sp)		# Save the original value of $s5 to the stack
	sw $s6, 20($sp)		# Save the original value of $s6 to the stack
	sw $s7, 16($sp)		# Save the original value of $s7 to the stack
	sw $t0, 12($sp)		# Save the original value of $t0 to the stack
	sw $t1, 8($sp)		# Save the original value of $t1 to the stack
	sw $t2, 4($sp)		# Save the original value of $t2 to the stack
	sw $t3, ($sp)		# Save the original value of $t3 to the stack 
	
	
	move $s0, $a0		# Store cx in the register $s0
	move $s1, $a1		# Store cy in the register $s1
	move $s2, $a2		# Store the radius in the register $s2
	move $s3, $a3		# Store the colour in the register $s3
		
	add $t1, $zero, 1	# Set $t1 to equal 1 (not is actual use, its being used as a temporary register)
	sub $s4, $t1, $s2	# Set $s4 (f) to f = 1 - radius
	add $s5, $zero, 1	# Set $s5 (ddF_x) to 1
	mul $s6, $s2, -2	# Set $s6 (ddF_y) to -2 * radius
	add $s7, $zero, 0	# Set x to equal zero
	add $t0, $zero, $s2	# Set y to equal the radius
	

	add $t1, $s0, $s2	# Set x1 to cx + radius
	sub $t3, $s0, $s2	# Set x2 to cx - radius

	la $a0, ($t1)		# Load $t1 into the x co-ordinate of point 1 of the line   
	la $a1, ($s1)		# Load $s1 into the y co-ordinate of point 1 of the line 
	la $a2, ($t3)		# Load $t3 into the x co-ordinate of point 2 of the line
	la $a3, ($s1)		# Load $s1 into the y co-ordinate of point 2 of the line 
	la $t9, ($s3)		# Load the colour of the line into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack
	
	jal drawline		# Enter the Subroutine "drawline"
	nop

fillygreaterthanx:		# Branch here if y is greater than x
	
	ble $s4, 0, fillflessthanzero	# Branch past if f is less than zero
	nop
	
	sub $t0, $t0, 1		# Decrement y by 1
	add $s6, $s6, 2		# Increment ddF_y by 2
	add $s4, $s4, $s6	# Increment f by ddF_y
		
fillflessthanzero:		# Branch here if f is less than zero
		
	add $s7, $s7, 1		# Increment x by 1
	add $s5, $s5, 2		# Increment ddF_x by 2	
	add $s4, $s5, $s4	# Increment f by ddF_x 
	
	
	add $t1, $s0, $s7	# Set $t1 (x1) to cx + x
	add $t2, $s1, $t0	# Set $t2 (y1) to cy + y
	sub $t3, $s0, $s7	# Set $t3 (x2) to cx - x
	
	la $a0, ($t1)		# Load $t1 into the x co-ordinate of point 1 of the line
	la $a1, ($t2)		# Load $t2 into the y co-ordinate of point 1 of the line
	la $a2, ($t3)		# Load $t3 into the x co-ordinate of point 2 of the line 
	la $a3, ($t2)		# Load $t2 into the y co-ordinate of point 2 of the line 
	la $t9, ($s3)		# Load the colour of the line into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack

	jal drawline		# Enter the Subroutine "drawline"
	nop	
	
	sub $t2, $s1, $t0	# Set $t2 (y1) to cy - y
	
	la $a0, ($t1)		# Load $t1 into the x co-ordinate of point 1 of the line  
	la $a1, ($t2)		# Load $t2 into the y co-ordinate of point 1 of the line 
	la $a2, ($t3)		# Load $t3 into the x co-ordinate of point 2 of the line 
	la $a3, ($t2)		# Load $t2 into the y co-ordinate of point 2 of the line 
	la $t9, ($s3)		# Load the colour of the line into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack
	
	jal drawline		# Enter the Subroutine "drawline"
	nop
	
	add $t1, $s0, $t0	# Set $t1 (x1) to cx + y
	add $t2, $s1, $s7	# Set $t2 (y1) to cy + x
	sub $t3, $s0, $t0	# Set $t3 (x2) to cx - y
	
	
	
	la $a0, ($t1)		# Load $t1 into the x co-ordinate of point 1 of the line 
	la $a1, ($t2)		# Load $t2 into the y co-ordinate of point 1 of the line  
	la $a2, ($t3)		# Load $t3 into the x co-ordinate of point 2 of the line  
	la $a3, ($t2)		# Load $t2 into the y co-ordinate of point 2 of the line 
	la $t9, ($s3)		# Load the colour of the line into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack
	
	jal drawline		# Enter the Subroutine "drawline"
	nop
		
	sub $t2, $s1, $s7	# Set $t2 (y1) to cy - x																																				
																																																																																																											
	la $a0, ($t1)		# Load $t1 into the x co-ordinate of point 1 of the line  
	la $a1, ($t2)		# Load $t2 into the y co-ordinate of point 1 of the line  
	la $a2, ($t3)		# Load $t3 into the x co-ordinate of point 2 of the line  
	la $a3, ($t2)		# Load $t2 into the y co-ordinate of point 2 of the line  
	la $t9, ($s3)		# Load the colour of the line into $t9 so it can be added to the stack
	addiu $sp, $sp, -4	# Decrement the stack pointer	
	sw $t9, ($sp)		# Save the value of $t9 (which is now the value of the colour paramter) to the stack
	
	jal drawline		# Enter the Subroutine "drawline"
	nop
																			
	bgt $t0, $s7 fillygreaterthanx		# Branch if y is greater than x
	nop			
				
	lw $t3, ($sp)		# Restore the original value of $t3 from the stack
	lw $t2, 4($sp)		# Restore the original value of $t2 from the stack
	lw $t1, 8($sp)		# Restore the original value of $t1 from the stack
	lw $t0, 12($sp)		# Restore the original value of $t0 from the stack
	lw $s7, 16($sp)		# Restore the original value of $s7 from the stack 
	lw $s6, 20($sp)		# Restore the original value of $s6 from the stack
	lw $s5, 24($sp)		# Restore the original value of $s5 from the stack
	lw $s4, 28($sp)		# Restore the original value of $s4 from the stack
	lw $s3, 32($sp)		# Restore the original value of $s3 from the stack
	lw $s2, 36($sp)		# Restore the original value of $s2 from the stack
	lw $s1, 40($sp)		# Restore the original value of $s1 from the stack
	lw $s0, 44($sp)		# Restore the original value of $s0 from the stack
	lw $ra, 48($sp)		# Restore the value of the return address ($ra) from the stack
	addiu $sp, $sp, 52	# Increment the stack pointer
	
	jr $ra
	nop
	
	
	# # # # # # # End fillcircle Subroutine # # # # # # # # # # # # # # # # # # # # # # # 
	
	
	# # # # # DrawDashedLine(int x1, int y1, int x2, int y2, int dash, int space, int colour) # # # #  
	#											 													#
	# 											 													#
	# Draws a line using "Bresenham's line drawing algorithm" between two points,		 			#
	# (x1, y1) and (x2, y2), and the line is the colour defined by 0x00RRGGBB, 		 				#
	# with each byte being an individual value from 0-255 (in hex)				 					#
	# Each pixel of the line is drawn using the SetPixel subroutine 			 					#
	#																								#
	#																								#
	# Registers used in the subroutine:																#
	#																								#
	# $s0 = X co-ordinate of point 1 (between 0 - 511)												#
	#																								#
	# $s1 = Y co-ordinate of point 1 (between 0 - 255)												#
	#																								#
	# $s2 = X co-ordinate of point 2 (between 0 - 511)												#
	#																								#
	# $s3 = Y co-ordinate of point 2 (between 0 - 255)												#
	#																								#
	# $s4 = Colour of the line (0x00RRGGBB)															#
	#																								#
	# $s5 = Reserved for dx, used in calculations													#
	#																								#
	# $s6 = Reserved for dy, used in calculations													#
	#																								#
	# $s7 = Reserved for sx, used to determine if line is complete									#
	#																								#
	# $t0 = Reserved for sy, used to determine if line is complete									#
	#																								#
	# $t1 = Reserved for err, variable designated by Bresenham's line algorithm						#
	#																								#
	# $t2 = Reserved for e2, variable designated by Bresenham's line algorithm						#
	#																								#
	# $t3 = Temporary register, used for storing temporary values while calculating dx or dy		#
	#																								#
	# $t4 = Length of the dashes of the line														#
	#																								#
	# $t5 = Length of space between dashes of the line												#
	#																								#
	# $t6 = Dash counter																			#
	#																								#
	# $t7 = Space counter																			#
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
	
drawdashedline:	
		
	# Stores the values of the s registers in the stack so they can be used in the subroutine
	
	addiu $sp, $sp, -68	# Decrement the stack pointer
	sw $ra, 64($sp)		# Save the value of the return address ($ra) to the stack
	sw $s0, 60($sp)		# Save the original value of $s0 to the stack
	sw $s1, 56($sp)		# Save the original value of $s1 to the stack
	sw $s2, 52($sp)		# Save the original value of $s2 to the stack
	sw $s3, 48($sp)		# Save the original value of $s3 to the stack
	sw $s4, 44($sp)		# Save the original value of $s4 to the stack
	sw $s5, 40($sp)		# Save the original value of $s5 to the stack
	sw $s6, 36($sp)		# Save the original value of $s6 to the stack
	sw $s7, 32($sp)		# Save the original value of $s7 to the stack
	sw $t0, 28($sp)		# Save the original value of $t0 to the stack
	sw $t1, 24($sp)		# Save the original value of $t1 to the stack
	sw $t2, 20($sp)		# Save the original value of $t2 to the stack
	sw $t3, 16($sp)		# Save the original value of $t3 to the stack 
	sw $t4, 12($sp)		# Save the original value of $t4 to the stack
	sw $t5, 8($sp)		# Save the original value of $t5 to the stack
	sw $t6, 4($sp)		# Save the original value of $t6 to the stack
	sw $t7, ($sp)		# Save the original value of $t7 to the stack 
	
	# Copies the values of the parameters passed in into the now free s registers
	
	move $s0, $a0		# Store the x co-ordinate of point 1 in $s0
	move $s1, $a1		# Store the y co-ordinate of point 1 in $s1
	move $s2, $a2		# Store the x co-ordinate of point 2 in $s2
	move $s3, $a3		# Store the y co-ordinate of point 2 in $s3
	lw $s4, 68($sp)		# Store the colour (takes form the stack) in $s4
	lw $t4, 72($sp)		# Store the dash count (takes from the stack) in $t4
	lw $t5, 76($sp)		# Store the space count (takes from the stack) in $t5
	
	add $t6, $zero, 0	# Set the dash counter to zero
	add $t7, $zero, 0	# Set the space dounter to zero
	
	# Main code for drawing the line on the bitmap
	
	subu $t3, $s2, $s0 			# Calculates x1 - x0 and store it in $t3
	abs $s5, $t3 				# Sets dx ($s5) to the absolute value of x1 - x0
	subu $t3, $s3, $s1			# Calculates y1 - y0 and stores it in $t3
	abs $s6, $t3				# Sets dy ($s6) to the absolute value of y1 - y0
	sub, $s6, $zero, $s6 		# Sets dy to -dy as dy is needed as a minus value later in calculations
								# it is turned minus via two's complement method
	bgt $s0, $s2, dashsxelse	# If x0 is greater than x1 then branch to sxelse
	nop
	li $s7, 1					# Set the value of sx ($s7) to 1
	b dashsxcomplete			# Branch around the sxelse section
	nop
	
dashsxelse:			# Branches to here if x0 is greater than x1
	li $s7, -1		# Sets the value of sx ($s7) to -1	

dashsxcomplete:					# Branches to here if x1 was greater than x0
	bgt $s1, $s3, dashsyelse	# If y0 is greater than y1 then branch to syelse
	nop
	li $t0, 1			# Sets the value of sy ($t0) to 1 
	b dashsycomplete	# Branch around the syelse section
	nop
	
dashsyelse:			# Branche shere is y0 is greater than y1
	li $t0, -1		# Sets the value sy ($t0) to -1
	
dashsycomplete:			# Branches to here if y1 was greater than y0
	addu $t1, $s5, $s6	# err is set to the value of dx - dy
	
dashdrawpixelloop:
	move $a0, $s0		# Store the x co-ordinate in $a0
	move $a1, $s1		# Store the y co-ordinate in $a1
	move $a2, $s4		# Store the colour in $a2
	
	beq $t6, $t4, dontsetpixel	# Branch if the dash counter is equal to the dash length
	nop
	
	add $t6, $t6, 1		# Increment the dash counter
	
	jal setpixel		# Enter the subroutine "setpixel"
	nop
	
	j dashcountcomplete	# Jump to dashcountcomplete
	nop

dontsetpixel:	
	
	beq $t7, $t5, resetcount	# Branch if the space count equals the space value 
	nop
	
	add $t7, $t7, 1				# Increment the space count
	
	j dashcountcomplete			# Jump to dashcountcomplete
	nop
	
resetcount:	
	
	add $t6, $zero, 0	# Set the dash count to zero
	add $t7, $zero, 0	# Set the space count to zero		

dashcountcomplete:

																								
	add $t2, $t1, $t1						# Sets e2 ($t2) to err ($t1) * 2 by calculating err + err   
	bgt $s6, $t2, dashe2notgreaterthandy	# Branch if -dy is greater than e2
	nop
	add $t1, $t1, $s6						# Calculate err = err - dy: err = $t1 , -dy = $s6
	add $s0, $s0, $s7						# Calculate x0 = x0 + sx: x0 = $s0 , sx = $s7
	
dashe2notgreaterthandy:	
	bgt $t2, $s5, dashe2greaterthandx	# Branch if e2 ($t2) is greater than dx ($s5)
	nop 
	add $t1, $t1, $s5					# Calculate err = derr + dx: err = $t1 , dx = $s5
	add $s1, $s1, $t0  					# Caluclate y0 = y0 + sy: y0 = $s1 , sy = $t0
dashe2greaterthandx:
	
	# To exit the loop x0 must now be equal to x1 and y0 much now be equal to y1
	# The two statements must be true to pass both branches and thus exits the loop
	
	bne $s0, $s2, dashdrawpixelloop	# If x0 ($s0) and x1 ($s2) are not 
	nop								# equal branch to drawpixelloop
	bne $s1, $s3, dashdrawpixelloop	# If y0 ($s1) and y1 ($s3) are not
	nop								# equal branch to drawpixelloop
	
	# Restores the original values of the s registers from the stack
	
	lw $t7, ($sp)		# Restore the original value of $t7 from the stack
	lw $t6, 4($sp)		# Restore the original value of $t6 from the stack
	lw $t5, 8($sp)		# Restore the original value of $t5 from the stack
	lw $t4, 12($sp)		# Restore the original value of $t4 from the stack
	lw $t3, 16($sp)		# Restore the original value of $t3 from the stack
	lw $t2, 20($sp)		# Restore the original value of $t2 from the stack
	lw $t1, 24($sp)		# Restore the original value of $t1 from the stack
	lw $t0, 28($sp)		# Restore the original value of $t0 from the stack
	lw $s7, 32($sp)		# Restore the original value of $s7 from the stack 
	lw $s6, 36($sp)		# Restore the original value of $s6 from the stack
	lw $s5, 40($sp)		# Restore the original value of $s5 from the stack
	lw $s4, 44($sp)		# Restore the original value of $s4 from the stack
	lw $s3, 48($sp)		# Restore the original value of $s3 from the stack
	lw $s2, 52($sp)		# Restore the original value of $s2 from the stack
	lw $s1, 56($sp)		# Restore the original value of $s1 from the stack
	lw $s0, 60($sp)		# Restore the original value of $s0 from the stack
	lw $ra, 64($sp)		# Restore the value of the return address ($ra) from the stack
	addiu $sp, $sp, 80	# Increment the stack pointer, taking itnto account the parameter pushed onto the stack
	
	jr $ra 		# Jump to the return address to exit the subroutine
	nop
	
	# # # # # # # # # End of the DrawLine subroutine # # # # # # # # # # # # # # # # # # # # # # # # 
