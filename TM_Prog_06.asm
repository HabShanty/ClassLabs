#############################################
#  Program Name:          TM_Prog_06
#  Author:                Thomas Moskal
#  Due Date:              4/5/21
#  Course/Section:        CSC 211-001
#  Program Description:   This program will prompt for up to 20 integers and then,
#							Using the bubble sort method, sort that array of integer inputs.
#
# Initial Algorithm:
#
#  1)   Initialize registers for loops and arrays
#  2)  	Prompt & store number of elements in array
#  3)   prompt for and store store integers in array
#  4)	Reinitialize and compute registers for bubble method	
#  5)   Compare and sort the array in ascending order using the bubble method
#  6)   Display the sorted array
#  7)   Display the maximum and minimum numbers
#  8)   End program
#
##############################################
#  Registers:
#	
#  	$t1 - # of elements in the array
#   $t2 - Outer loop counter (i)
#	$t3 - Inner loop counter (j)
#	$t4 - End index for outer loop (($t1 - 1) * 4)
#	$t5 - End index for inner loop ($t1 * 4)
#	$t6 - (J - 1) 
#	$t7 - contents of array (J)
#	$t8 - contents of array (J-1)
#	$t9	- Temporary register/counter
#
#########################
#  Outputs:
#
#	intAmt:		.asciiz	  "How many integers will you be entering? (No more than 20 please)\n"
#	intPrompt:  .asciiz   "Enter an Integer: "   	   
#	comma:      .asciiz   ", "
#	p1:     	.asciiz   "The minimum number is "
#	p2:     	.asciiz   "\nThe maximum number is "
#	header:     .asciiz   "Your sorted array is: "
#	crlf:   	.asciiz   "\n" 
#
##########################
#  Additional:
#
#   array:  	.word 80							  # 20 words 
#	
#	
#	Computations:
#	$t4 = (($t1 - 1) * 4)
#	$t5 = ($t1 * 4)
#
##########################
#  Inputs:
#	
#  $t1 - # of elements in the array
#  $v0 - holds integer inputs before being stored in array	
#
##########################
#  Refined Algorithm:
#
#
#  1)  Initialize registers for loops and arrays
#		a) Set $t0 to 0 for array index
#		b) Set $t9 to 0 for counter
#
#  2)  Prompt & store number of elements in array
#		a) Load address of intAmt to $a0 and call code (4) to display String
#		b) Call code (5) to read integer input
#		c) Move input from $v0 to $t1 
#
#  3)  prompt for and store store integers in array
#		a) Begin While
#			b) Load address of intprompt to $a0 and call code (4)
#			c) call code (5) to read integer input
#			d) Store $v0 into the current index position of the array
#			e) Increment index position by 4 (bytes)
#			f) increment While counter by 1
#		g) branch to while if counter < number of integers to be input
#
#  4)  Reinitialize and compute registers for bubble method
#		a) set $t2 to 0 for the outer loop index
#		b) set $t3 to 4 for the inner loop index
#		c) Set $t9 to 0, reset to be a temporary register
#		d) to get end index, subtract 1 from $t1
#		e) then multiply $t4 by 4
#		f) multiply $t1 by 4 for the inner loop end index
#
#  5)  Compare and sort the array in ascending order using the bubble method 
#		a) outer: branch to endOuter if outer counter equals outer end (when i = (# of items - 1) * 4)
#			b) inner: branch to endInner if inner counter equals inner end (when  j = (# of items) * 4)
#				c) compute j – 1 by subtracting 4 bytes from j
#				d) load word at array(j - 1) into a temporary register
#				e) load word at array(j) into a temporary register
#				f) branch to noSwap if first temporary register  <  second temporary register (for some reason this works for me although its different in the algorithm?)
#					g) store array(j)  into temp register
#					h) store array(j - 1)into array(j)
#					i) store temp register into array(j - 1)
#				j) noSwap:  increment j by 4 because each integer is 4 bytes
#				k) jump to inner
#			l) endInner
#			m) increment i by 4 because each integer is 4 bytes
#			n) initialize j back to 4 to begin next inner loop value
#			o) jump to outer
#		p) endOuter
# 
#  6)  Display the sorted array  
#    	a) for: branch to endfor when counter = # of items in the array
#			b) load word from array at current position ($t8) to $t7
#			c) move that integer ($t7) to $a0 and call code (1) to display 
#			d) Increment array position ($t8) by 4
#			e) increment loop counter ($t9) by 1
#		  f) j for
#		g) endfor:
#  
#  7)  Display the maximum and minimum numbers 
#    	a) reset $t7 to 0 to hold minimum
#		b) reset $t8 to 0 to hold maximum
#		c) reset $t9 to 0 to be first index position of array
#		d) load crlf to $a0 and call code (4) to display 			a line space
#		f) load p1 to $a0 and call code (4) to display 				"the minimum number is "
#		g) load the word at the first index position ($t9) to ($t7)
#		h) move that integer to $a0 and call code (1) to display 	The minimum number
#		i) load p2 to $a0 and call code (4) to display				"\nThe maximum number is "
#		j) load the word at the final index position ($t4) to ($t8)
#		k) move that integer to $a0 and call code (1) to display 	The maximum number
#		l) load crlf to $a0 and call code (4) to display 			a line space
#
#  8)  End program 
#    	a) call code 10 to end program  
#
#
#
##############################################
		
			
			.text
        .globl main
main:

		
		
	#instantiate registers for input and array fill sections
		
		li $t0, 0 		# initialize array index to 0
		li $t9, 0 		# initialize counter to 0
			
		
		
	#Prompt, and you shall recieve... input	
		
		la $a0, intAmt			# display prompt to ask for amt of integers to be input
		li $v0, 4				# This sets the size of the array
		syscall	
	
		li $v0, 5				# call code to read int (5)
		syscall
	
		move $t1, $v0			# move Number of inputs to be added to its register
	  

	#Now that the size of the array is known, populate it
		
while:  
		la $a0, intPrompt        # Load address of integer input prompt and call code (4) 
		li $v0,4                 
		syscall                  

		li $v0,5                 # read input -> v0
		syscall                  # 5 is sys call for read int
	
	
		sw $v0, array($t0)		 #Store integer into array
    
	
		add $t0,$t0,4            # increment index position by 4 
		add $t9,$t9,1            # increment counter
    
   
		blt $t9,$t1,while        # branch to while if counter < number of integers to be input
       
   
    # End While to populate the array 
wend: 
     
		la $a0,crlf         # Display "cr/lf" to skip a line
        li $v0,4            # a0 = address of message
        syscall             # v0 = 4 which indicates display a string

	

	#Initialize registers for bubble-loop
	
		li $t2, 0			# outer loop counter
		li $t3, 4			# inner loop counter
		li $t9, 0			# reset to be temporary register
		
		#End index for outer loop ($t4)
		sub $t4, $t1, 1		# To Compute end index of outer loop, subtract 1 from # of items in array.  
		mul $t4, $t4, 4		# Then multiply by 4 to get the correct byte size
		
	
		
		#End index for inner loop ($t5)
		mul $t5, $t1, 4		# To compute end index of inner loop, multiply # of items in array by 4.
		

	#Begin sorting
		
OUTER:
		
		beq $t2, $t4, endOuter		# When outer counter equals outer end, end While loop
		

		INNER:
			
			beq $t3, $t5, endInner		# End inner loop when inner counter equals inner end
			
			sub $t6, $t3, 4				# get J-1 
			
			li $t7, 0					# reset temporary register 1
			li $t8, 0					# reset temporary register 2
			
			lw $t7, array($t6)			# load contents of array from J-1
			lw $t8, array($t3)			# load contents of array from J
			
			#branch to noSwap if first temporary register  <  second temporary register
			blt $t7, $t8, noSwap

						
			#Perform the swap
			move $t9, $t8			# store array(j) in temp register
					
			sw $t7, array($t3)	 	# store array(j - 1)into array(j)
			sw $t9, array($t6)		# store temp register into array(j - 1)
						
			noSwap:
			
			add $t3, $t3, 4			# increment J array position
			j INNER

		endInner:

	add $t2, $t2, 4					# add 1 to outer loop counter
	li $t3, 4						# re-initialize J
	j OUTER

endOuter:

	
		li $t7, 0			#reset to hold minimum	
		li $t8, 0			#reset to hold maximum
		li $t9, 0			#reset to be first place index	
		
		
		la $a0,header       # Display "Your sorted array is: "
        li $v0,4            # a0 = address of message
        syscall             # v0 = 4 which indicates display a string
		
		la $a0,crlf         # Display "cr/lf"
        li $v0,4            # a0 = address of message
        syscall             # v0 = 4 which indicates display a string
		
		
		
		#print array with For loop
		for:	beq, $t9, $t1, endfor		# 
				
				
				lw $t7, array($t8)	# load word from array at current position
				move $a0,$t7        # move that integer to $a0
				li $v0,1			# call code 1 to display
				syscall	
				la $a0,crlf         # Display "cr/lf"
				li $v0,4            # a0 = address of message
				syscall             # v0 = 4 which indicates display a string	
					
				
				add $t8, $t8, 4		#increment array position
				add $t9, $t9, 1		#increment for loop counter			
					
				j for 
				
		endfor:
		
		
		
		#Display min and max, which are at the beginning and end of the array
		
		li $t7, 0			# reset to hold minimum	
		li $t8, 0			# reset to hold maximum
		li $t9, 0			# reset to be first place index
		
		
		la $a0,crlf         # line space
        li $v0,4             
        syscall              
		
		la $a0,p1           # Display "The minimum number is "
        li $v0,4             
        syscall                 
		
        lw $t7, array($t9)
	    move $a0,$t7        # Display The minimum number 
        li $v0,1
        syscall
		
		
        la $a0,p2           # Display a line space and "The maximum number is "
        li $v0,4             
        syscall              
		
        lw $t8, array($t4)
		move $a0,$t8        # Display The maximum number 
        li $v0,1
        syscall
		
		
        la $a0,crlf         # line space
        li $v0,4             
        syscall              
		
		
        li $v0,10           # End Of Program
        syscall 
	

	

#Data section

.data



intAmt:		.asciiz	  "How many integers will you be entering? (No more than 20 please)\n"
intPrompt:  .asciiz   "Enter an Integer: "   	 
comma:      .asciiz   ", "
p1:     	.asciiz   "The minimum number is "
p2:     	.asciiz   "\nThe maximum number is "
header:     .asciiz   "Your sorted array is: "
crlf:   	.asciiz   "\n" 


array:  	.word 80							  # 20 words		  