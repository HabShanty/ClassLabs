#############################################
#  Program Name:          Lab_09
#  Author:                Thomas Moskal
#  Due Date:              3/22/21
#  Course/Section:        CSC 211-001
#  Program Description:   This program will ask for 10 integer inputs and then display the minimum and maximum number of those inputs.
#
# Initial Algorithm:
#
#  1)  Initialise array
#  2)  Get first input  
#  3)  Get first min/max
#  4)  Begin While
#  5)  Prompt for remaining integers
#  6)  Compare new integer to min/max 
#  7)  Store integer in array  
#  8)  End While
#  9)  Display min/max
# 10)  End program
#
#
##############################################
#  Registers:
#
#	$t0 	- array index
#	$t1		- input register
#	$t2 	- next element
#	$t3		- The min register
#	$t4 	- The max register
#	$t9		- loop counter
#	$t8		- Size of the array (10)
#	$t7		- UI loop counter   
#  
#	$v0		- displaying/reading integers and call codes
#	$a0		- Displaying Strings
#
#########################
#  Outputs:
#
#	prompt1: .asciiz "Please enter integer 1: "	# String for first integer prompt
#	prompt2: .asciiz "Please enter integer "	# Beginning of integer prompts
#	prompt3: .asciiz ": "						# Ending o f integer prompts
#
#	p1:     .asciiz "The minimum number is "	 # String for displaying minimum number
#	p2:     .asciiz "\nThe maximum number is "	 # String for displaying maximum number
#	crlf:   .asciiz "\n" 
#
##########################
#  Additional:
#
#  array:  .word 40							 # This array contains 10 words.  4 bytes per word.
#
##########################
#  Inputs:
#
#  $t1		- input register
#
#
##########################
#  Refined Algorithm:
#
#
#  1)  Initialise array
#		a) initialise address register ($t0) of array to 0
#		b) set input register ($t1) to 0
#		c) Set the loop count for the UI display ($t7) to 2
#		d) Set the size of array ($t8) to 10
#		e) Set the While loop counter ($t9) to 0
#
#  2)  Get first input
#		a) load address of first display prompt, call code 4  
#		b) call code 5 to read integer input
#		c) move input to input register ($t1)
#		d) Store input into array using sw (word amounts)
#
#  3)  Get first min/max
#		a) Set min ($t3) to array at position a[0]
#		b) Set max ($t4) to array at position a[0]
#		c) Increment index point ($t0) by 4 (4 bytes = 1 word)
#		d) Increment counter for While loop +1
#
#  4)  Begin While
#
#  5)  Prompt for remaining integers
#		a) load address of second display prompt (prompt2), call code 4
# 		b) load address of UI loop counter ($t7), call code 1
#		c) load address of third display prompt (prompt3), call code 4
#		d) call code 5 to read integer input
#		e) move input to input register ($t1) 
#
#  6)  Compare new integer to min/max  
#    	a) if input register ($t1) is greater than or equal to min ($t3) then BRANCH to notMin, else
#		b) 		Set min to current input register ($t1) value  
#		c) if input register ($t1) is less than or equal to max ($t3) then BRANCH to notMax, else
#		d)		Set max to current input register ($t1) value	
#  
#  7) Store integer in array  
#    	a) Store input register ($t1) in current array position
#		b) increment loop counter ($t9)
#		c) increment UI loop counter ($t7)
#
#  8) End While  
#    	a) Branch to WHILE: if loop counter ($t9) is smaller than size of the array ($t8) else wend: 		 
#
#  9) Display min/max 
#		a) load address of minimum display string (p1), call code 4
#       b) load address of min register ($t3), call code 1
#       c) load address of maximum display string (p2), call code 4
#       d) load address of max register ($t4), call code 1
#
#  10) End program
#		a) Call code (10) to end program
#
#	
#		
##############################################

	

	.text
	.globl main

main:
        li $t0,0	        	# t0 = address of array, initialized to 0
		li $t1,0				# input register, set to 0
		li $t7,2				# Loop counter UI (display aesthetics)
        li $t8,10	        	# Size of array		
		li $t9,0				# Loop counter	set to 0


	
		la $a0, prompt1			#Prompt for first integer
		li $v0, 4				#Call (4) to display string
		syscall
		
		
		li $v0, 5				#Call (5) to read integer input to $v0
		syscall
		
		move $t1, $v0			# Move integer input from $v0 to $t1
		sw $t1, array($t0)		# Store integer at #t1 into array at current position (position 0)
        
		lw $t3, array($t0)      # t3 = min = a[0] (initialization)
        lw $t4, array($t0)      # t4 = max = a[0] (initialization)

		
        add $t0,$t0,4     		# move pointer ahead to next array element a[1]
        add $t9,$t9,1     		# increase counter for incoming loop
		
				
		   
			#Populate the rest of the array in a loop
			
while:  
        la $a0, prompt2         # prompt for integer
        li $v0,4                # a0 = address of string
        syscall                 # v0 = 4, indicates display a String
		
		move $a0,$t7            # Displays current integer being asked for 
        li $v0,1				# Call (1) to display integer
        syscall
		
        la $a0, prompt3         # prompt for integer
        li $v0,4                # a0 = address of string
        syscall                 # v0 = 4, indicates display a String		

        li $v0,5                # enter input -> v0
        syscall                 # 5 is sys call for read int
		
		move $t1, $v0           # store word int to a[i]

			#begin Min/Max compares
			
        bge $t1,$t3,notMin  	# if array element is >= min goto notMin
        move $t3,$t1        	# min = a[i]        
		
notMin: 
		ble $t1,$t4,notMax 		# if array element is <= max goto notMax
        move $t4,$t1       	    # max = a[i]
		
notMax: 
			#Store integer into array position
		sw $t1, array($t0)      #Store the integer into the current index position
   
        add $t0,$t0,4           # move pointer ahead to next array element
        add $t9,$t9,1           # increment counter
		add $t7,$t7,1			# incremeent ui counter
    
        blt $t9,$t8,while       # branch to while if counter < size of array
        
			# End While which populates the array
			
wend:

		la $a0,crlf         	# Display "cr/lf"
        li $v0,4           		# a0 = address of message
        syscall            		# v0 = 4 which indicates display a string
		
        la $a0,p1           	# Display "The minimum number is "
        li $v0,4            	# a0 = address of message
        syscall             	# v0 = 4 which indicates display a string       
       
		move $a0,$t3        	# Display the minimum number 
        li $v0,1
        syscall
        
		la $a0,p2           	# Display "The maximum number is "
        li $v0,4            	# a0 = address of message
        syscall             	# v0 = 4 which indicates display a string
        
		move $a0,$t4        	# Display the maximum number 
        li $v0,1
        syscall
        
		la $a0,crlf         	# Display "cr/lf"
        li $v0,4           		# a0 = address of message
        syscall            		# v0 = 4 which indicates display a string
        
		li $v0,10           	# End Of Program
        syscall 
        

.data 
prompt1: .asciiz "Please enter integer 1: "	 # String for first integer prompt
prompt2: .asciiz "Please enter integer "	 # Beginning of integer prompts
prompt3: .asciiz ": "						 # Ending o f integer prompts

p1:     .asciiz "The minimum number is "	 # String for displaying minimum number
p2:     .asciiz "\nThe maximum number is "	 # String for displaying maximum number
crlf:   .asciiz "\n" 
array:  .word 40							 # This array contains 10 words.  4 bytes per word.



################ Output #################
#                                       #
# The minum number is                   #
# The maximum is                        # 
#                                       #
#########################################