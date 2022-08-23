#############################################
#  Program Name:          TM_Prog_05
#  Author:                Thomas Moskal
#  Due Date:              3/22/21
#  Course/Section:        CSC 211-001
#  Program Description:   This program will count the number of characters in a string input, excluding the enter character.
#							It will then display the count of characters and the count of vowels in the string.
#
# Initial Algorithm:
#
#  1)  Initialise arrays and loop counters
#  2)  Get string input
#  3)  WHILE
#  4)  Store characters into array while comparing to vowel array  	
#  5)  for
#  6)  Count the number of characters and number of vowels in the string
#  7)  endfor/ENDWHILE
#  8)  Display results
#  9)  End program 
#
##############################################
#  Registers:
#
#
#	$t0		- load byte register for string input	
#	$t1		- input char counter
#	$t2		- register that holds input byte
#	$t3		- array index position		
#	$t4		- str index counter
#	$t5		- str address pointer
#	$t7		- Vowel count register
#	$t8		- vowel loop index position
#  
#
#########################
#  Outputs:
#
#	vowelArray: .asciiz "aeiou"					     	#Vowels to be analyzed
#	prompt1: 	.asciiz "Please enter word here: "    	#Prompt for string input
#	count:		.asciiz "Total size of the string is: " #Dispaly string size
#	vowels:		.asciiz "The amount of vowels are : " 	#Display the number of vowels
#	crlf:   	.asciiz "\n"                          	#new line command
#
##########################
#  Additional:
#
#  	$v0		- displaying/reading integers and call codes
#	$a0		- Displaying Strings	
#	$a1		- Holding string size    
#
##########################
#  Inputs:
#
#  inString: 	.space 82							  #Set input string length maximum
#  strArray:  	.word 20							  # This array can contain 20 characters.  1 byte per char
#
##########################
#  Refined Algorithm:
#
#
#  1)  Initialise arrays and loop counters
#		a) Set $t1 to 0
#		b) Set $t3 to 0
#		c) Set $t4 to 0
#		d) Set $t8 to 0
#
#  2)  Get string input
#		a) load address of prompt1 to $a0, call code 4
#		b) Set string length in $a1 to 81
#		c) load address of inString to $a0, call code 8
#		d) load the address of instring to an integer register ($t2)
#
#  3)  WHILE 
#
#  4)  Store characters into array while comparing to vowel array
#		a) load byte of instring address ($t2) to $t0
#		b) if $t0 is equal to zero then branch to ENDWHILE  
#
#  5)  for
# 
#  6)  Count the number of characters and number of vowels in the string  
#    	a) if For loop counter reaches is equal to 5 then branch to endfor
#		b) Load the byte from first position in vowelArray to $t5 
#		c) If string input character is not equal to vowelArray character then branch to notVowel
#		d) 		Else, add 1 to vowel counter
#		e) increment vowelArray position and for loop counter 
#  
#  7)  endfor/ENDWHILE 
#    	a) When For loop counter is equal to 5 move to endfor
#		b) Reset the vowel array position register to 0
#		c) Reset the for loop counter to 0
#		d) Store the current character in the strArray Array's current position
#		e) Add 1 to character counter length
#		f) Add 1 to input String character position register ($t2)
#		g) Add 1 to the positon of the input string array 
#
#  8) Display results  
#    	a) subtract 1 from the character counter ($t1) to account for enter key
#		b) load address of count string, call code 4 
#		c) move character counter ($t1) to $a0 for display, call code 1
#		d) load address of crlf string, call code 4
#		e) load address of vowels string, call code 4
#		f) move vowel counter register ($t7) to $a0, call code 1
#
#  9) End program
#		a) load immediate to $v0 call code 10
#       b) End program
#       
#
#
#
##############################################


	.text
	.globl main

main:




			#Initialise strArray
			
				li $t3,0             # t3 = strArray index set to 0
				li $t1,0             # t1 = counter/strArray size
				li $t4,0			 # t4 = str index counter set to 0
				li $t8,0			 # vowel loop index pos
				
			#Prompt for string input
			la $a0, prompt1	    	# load address of prompt string			
			li $v0, 4	     		# load call code to print prompt string into register	
			syscall		     		# call to display prompt
	
			#Read string  
			li $a1, 81				# Set string length
			la $a0, inString		# load address of inString
			li $v0, 8				# load call to read string from keyboard
			syscall					# call to read String 
	
			#load address to $t2 and set count
			la $t2, inString		# set $t2 to point at inString
						
						
				#Set while loop to continue as long as a character is returned at the beginning of each loop
				
WHILE:		lb $t0, ($t2)					# load byte from inString
			beqz $t0, ENDWHILE				# IF t0 (input) is equal to zero (end of input) BRANCH to ENDWHILE
			
			
			for:	beq, $t8, 5, endfor				# if for loop counter ($t8) = 5 then branch to endfor
					lb $t5, vowelArray($t4)			# load byte from the vowelArray Array at current position
					bne, $t0, $t5 notVowel			# if the current character is not equal to the vowel string then branch to notVowel
					add $t7, $t7, 1					# If it is equal, add 1 to vowel counter
					
			notVowel:		
					add $t4, $t4, 1			#increment vowelArray position
					add $t8, $t8, 1			#increment for loop counter			
					
					j for
			endfor:
					
					
			li $t4, 0				#reset list of vowels for loop register
			li $t8, 0				#Reset counter for for loop
		
				
			sw $t0, strArray($t3)	#Store the character into a word space of the strArray Array
			
			add $t1, $t1, 1			# Increment t1 by 1 (t1 is counting the length)
			add $t2, 1				# Increment t2 by 1 (index value of the next character)
			add $t3, $t3, 4			# increment position of array
			j WHILE					# End while loop commands


ENDWHILE:

			sub $t1, $t1, 1			#Subtract the enter key character from $t1


			la $a0, crlf	    	# load address of prompt string			
			li $v0, 4	     		# load call code to print prompt string into register	
			syscall		     		# call to display prompt
			
			la $a0, count	    	# load address of prompt string			
			li $v0, 4	     		# load call code to print prompt string into register	
			syscall		     		# call to display prompt
			
			move $a0,$t1        	# move character counter ($t1) to $a0 for display
			li $v0,1				# load call code for printing integer (1) into $v0
			syscall					# system call

			la $a0, crlf	    	# load address of prompt string			
			li $v0, 4	     		# load call code to print prompt string into register	
			syscall		     		# call to display prompt
			
			la $a0, vowels	    	# load address of prompt string			
			li $v0, 4	     		# load call code to print prompt string into register	
			syscall		     		# call to display prompt
			
			move $a0,$t7        	# move counter ($t3) to $a0 for display
			li $v0,1				# load call code for printing integer (1) into $v0
			syscall					# system call			

			la $a0,crlf         	# Display "cr/lf"
			li $v0,4           		# a0 = address of message
			syscall            		# v0 = 4 which indicates display a string
        
			li $v0,10           	# End Of Program
			syscall 			
			
			
				




#Data section

.data


vowelArray: .asciiz "aeiou"					     #Vowels to be analyzed
prompt1: 	.asciiz "Please enter word here: "    #Prompt for string input
count:		.asciiz "Total size of the string is: " #Dispaly string size
vowels:		.asciiz "The amount of vowels are : " #Display the number of vowels
inString: 	.space 82							  #Set input string length maximum
crlf:   	.asciiz "\n"                          #new line command
strArray:  	.word 20							  # This array can contain 20 characters.  1 byte per char
			  
			  
			  ######### End Of Program_05.asm ##########

							#### Input ######
							#               #
							#               #
							#               #
							#################			
			
			
			
					
################################# Output ##################################
#			               												  #
#                                                                         # 
#                                                                         #
#														                  #
#			                                                              # 
###########################################################################