#############################################
#  Program Name:          TM_Program_04
#  Author:                Thomas Moskal
#  Due Date:              3/8/21
#  Course/Section:        CSC 211-001
#  Program Description:   This program will read an integer from the user and print out digits
#							from 1 to that number in a right orientation.  
#
# Initial Algorithm:
#
#  1)  Display prompt for user to enter integer
#  2)  Read integer output and move it to $t1	
#  3)  Set variables
#  4)  Begin PRE_WHILE loop to find the maximum amount of spaces needed in outputs	
#  5)  Begin main WHILE loop 
#  6)  Add Enter carriage every 10 integers 
#  7)  Check if spacing is correct for right orientation  
#  8)  Add a space n times to get correct right orientation before integer display
#  9)  Display current number
# 10)  Place space between integers
# 11)  Increment WHILE loop and INNER_WHILE counters + 1 ($t2 & $t3)
# 12)  End program
#
##############################################
#  Registers:
#
#  $t1          Integer input by user
#  $t2 			INNER1 loop counter 
#  $t3 			set outer loop current number to 1
#  $t4 			used to find exponential limits (10, 100, 1000, 10000) to calculate any input
#  $t5 			constant multiplier of 10	
#  $t6			maximum amount of spaces needed relative to input
#  $t7			counter for IN_WHILE3 loop
#  $t8			tracks exponent limits to format properly
#
#########################
#  Outputs:
#
#  prompt1  -  "Please enter String here "
#  space    -  " "
#  end1     -  New line command		  	
#  
#
##########################
#  Additional:
#
#  #t3      -  current number of main while loop  
#
##########################
#  Inputs:
#
#  $t1      - Integer input by user
#
##########################
#  Refined Algorithm:
#
#
#  1)  Display  prompt for user to enter input string
#		a) load address of prompt1 into $a0
#		b) load call code for printing string (4) into $v0
#		c) system call
#
#  2)  Read integer output and move it to $t1
#		a) load call code for reading integer input (5)
#		b) system call
#		c) move $v0 to $t1
#
#  3)  Set variables
#		a) set $t2 to 0			set INNER1 loop counter to 0
#		b) set $t3 to 1			set outer loop current number to 1
#		c) set $t4 to 1			used to find exponential limits (10, 100, 1000, 10000) to calculate any input
#		d) set $t5 to 10		constant multiplier of 10
#		e) set $t6 to 1			n amt of times to add space before integer for right-orientation
#		f) set $t7 to 0			Counter for amt of times space is displayed before integer
#		g) set $t8 to 10		limit used to designate when to subtract a space before integer
#
#  4) Begin PRE_WHILE loop to find the amount of spaces needed in front of each integer output
#		a) IF t4 is greater than or equal to t1 BRANCH to END_PRE_WHILE
#		b) ELSE multiply t4 by 10 each iteration (exponents of 10)
#		c) counter to record maximum amount of spaces needed to display
#		d) End commands IF $t4 is not greater than or equal to $t1
#		e) END_PRE_WHILE
#
#  5)  Begin main WHILE loop that prints output
#		a)WHILE IF $t3 is larger than $t1 then branch to END_OUTER
# 
# 	 6)  Add Enter carriage every 10 integers 
#   	 	a) INNER_WHILE IF $t2 is greater than 10 then branch to END_INNER_WHILE
#			b) ELSE load end1 address for new line display
#			c) load call code for printing string (4) into $v0
#			d) system call
#			e) Set inner loop counter back to 0
#			f) END_INNER_WHILE
#  
# 	 7)  Check if spacing is correct for right orientation
# 		   	a) IN_WHILE2 If current number ($t3) < $t8 then branch to END_INNER2
#			b) ELSE subtract 1 loop of space display
#			c) multiply $t8 by to set limit to next exponent 
#			d) END_INNER2
#
# 	 8)  Add a space n times to get correct right orientation before integer display
#  		  	a) IN_WHILE3 If $t7 is greater than or equal $t6 then branch to END_INNER3
#			b) display a blank space
#			c) # load call code for printing string (4) into $v0
#			d) system call
#			e) increment counter by 1
#			f) END_INNER3
#			g) reset counter to 0 after
#
#  9)  Display current number
#		a) move current number ($t3) to $a0 for display
#       b) load call code for printing integer (1) into $v0
#       c) system call
#
#  10)Place space between integers
#		a) display a blank space
#		b) load call code for printing string (4) into $v0
#		c) system call
#
#  11)Increment WHILE loop and INNER_WHILE counters +1 ($t2 & $t3)
#		a) Increment inner loop
#		b) Incremenet outer loop/current number
#		c) End OUTER WHILE
#										
#  12)End program
#  		a) load call code for ending the program into v0 (10)
#		b) system call
#
#
##############################################


	.text
	.globl main

main:


			#1)
		    #Prompt for string input
			la $a0, prompt1	    	# load address of prompt string			
			li $v0, 4	     		# load call code to print prompt string into register	
			syscall		     		# call to display prompt
			
			#2)
		    #Read integer input
			li $v0, 5	    		#calls code to read integer input (5)
			syscall				    #system call

			#Move integer to $t1
			move $t1, $v0	     	#Move integer input to $t1 storage
			
			#3)
			#Set Variables 
			li $t2, 0			    #set INNER1 loop counter to 0
			li $t3, 1				#set outer loop current number to 1
			li $t4, 1			    #used to find exponential limits (10, 100, 1000, 10000) to calculate any input
			li $t5, 10				#constant multiplier of 10
			li $t6, 1				#n amt of times to add space before integer for right-orientation
			li $t7, 0				#Counter for amt of times space is displayed before integer
			li $t8, 10				#limit used to designate when to subtract a space before integer
			

			#This loop will designate the amount of spaces needed in front of the integers
			#it is relative to the users input
		
			#4)
PRE_WHILE:	bge $t4, $t1 END_PRE_WHILE		#IF t4 is greater than or equal to t1 BRANCH to END_PRE_WHILE
			mul $t4, $t4, $t5				#multiply t4 by 10 each iteration (exponents of 10)
			add $t6, $t6, 1					#counter to record maximum amount of spaces needed to display
			j PRE_WHILE						#End commands IF $t4 is not greater than or equal to $t1
				
					
END_PRE_WHILE:
			
			#5)
			#Begin main while loop
WHILE:		bgt $t3, $t1, END_OUTER			
			

			
			#6)
			#Adds enter carriage every 10 integers
			#if counter ($t2) < 10  then branch to END_INNER_WHILE
			INNER_WHILE: 	blt $t2, 10, END_INNER_WHILE		
							
						#else counter ($t2) = 10.  Move to next line and reset counter							
						la $a0,endl      		# load end1 address for new line display
						li $v0,4				# load call code for printing string (4) into $v0
						syscall					# system call
							
						#Set inner loop counter back to 0
						li $t2, 0				#set $t2 to 0
							
							
						#End inner loop
						j INNER_WHILE			
						
			#end INNER_WHILE
			END_INNER_WHILE:		
				
			#7)	
			#Check if spacing is correct
			#If current number ($t3) < $t8 then branch to END_INNER2
			IN_WHILE2: 	blt $t3, $t8, END_INNER2		
							
						#else counter ($t3) = $t8.
						#Every time there is one less character in the integer ie.. 100 --> 99 or 10 --> 9
						#subtract one space from display
						sub $t6, $t6, 1			#subtract 1 loop of space display
						mul $t8, $t8, $t5		#multiply $t8 to next exponent 
							
						#End second inner loop
						j IN_WHILE2


			END_INNER2:

				
			#8)
			#Add a space n times to get correct right orientation before integer display
			#If $t7 is greater than or equal $t6 then branch to END_INNER3
			IN_WHILE3:  bge $t7, $t6 END_INNER3
						
						
						#Else display a space
						la $a0, space      		# display a blank space
						li $v0,4				# load call code for printing string (4) into $v0
						syscall					# system call
						
						add $t7, $t7, 1			#increment counter by 1
						j IN_WHILE3
					
			END_INNER3:			
					
					
			#Happens every loop commands start here
			
			li $t7, 0				#Sets $t7 count to 0
			
			#9)	
			#Display current number
			move $a0,$t3        	# move counter ($t3) to $a0 for display
			li $v0,1				# load call code for printing integer (1) into $v0
			syscall					# system call
													
			#10)		
			#space between integers
			la $a0, space      		# display a blank space
			li $v0,4				# load call code for printing string (4) into $v0
			syscall					# system call
			
			#11)
			#increment counters
			add $t2, $t2, 1			# Increment inner loop
			add $t3, $t3, 1			# Incremenet outer loop/current number

			j WHILE	
#End OUTER WHILE
END_OUTER:

			
			#12)
			#End program
			li,$v0,10				# load call code for ending the program into v0 (10)		
			syscall					# system call

#Data section

.data



prompt1: 	.asciiz "Please enter integer here: "    		  #Prompt for string input
endl: 		.asciiz "\n"                             	 	  #new line command
space:		.asciiz " "									  	  #adds a blank space to string command	
			  
			  
######### End Of Program_04.asm ##########

