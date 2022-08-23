#############################################
#  Program Name:          
#  Author:                Thomas Moskal
#  Due Date:              4/12/21
#  Course/Section:        CSC 211-001
#  Program Description:   This program will convert the Hexidecimel equivalent of my initials
#							into it's ASCII character
#
# Initial Algorithm:
#
#  1)  Initialize the hexidecimel word and loop counter
#  2)  Display String to user
#  3)  For
#  	4)	Print the 8 least most bits of the word  
#  5)  EndFor	  
#  6)  End program 
#
##############################################
#  Registers:
#
#  $t1 -	For loop Counter
#  $t2 -	Hexidecimel register		
#  
#
#########################
#  Outputs:
#
#  display: 	.asciiz		"The hexidecimel number of 0x4D4D4154 is equal to my initials: \n"
#  
#
##########################
#  Additional:
#
#    
#
##########################
#  Inputs:
#
#  $t2 - 0x4D4D4154
#
##########################
#  Refined Algorithm:
#
#
#  1)  Initialize the hexidecimel word and loop counter
#		a) Load immediate '0x4D4D4154' into register ($t2)
#		b) Set $t1 to 0 for loop counter
#
#  2)  Display String to user
#		a) Load address display to $a0 and call code (4) to print String
#
#  3)  For
#		a) Branch to endFor when $t1 = 4
#
#  		4)  Print the 8 least most bits of the word
#			a) Use mask 0xff on register ($t2) to extract the least 8 bits
#			b) Call code (11) to print out contents of $a0 as ascii
#			c) Rotate the contents of register $t2 to the right by 8 bits
#			d) increment For loop counter by 1
#
#  5)  EndFor
# 
#  6)  End program   
#    	a) Call code (10) to End Program
#  
#
#
##############################################


	.text
	.globl main

main:

		li $t2, 0x4D4D4154	# Load the word into $t2 register
		li $t1, 0 			# Set loop counter to 0

		la $a0, display		# Display String explaining the operation	
		li $v0, 4			# Call code (4) to print string
		syscall

For:	#Begin for loop
	
	beq $t1, 4, endFor		# Branch to endFor when $t1 = 4
						
		andi $a0, $t2, 0xff	# Use mask 0xff (least 8 bits) 
		li $v0, 11			# Call code (11) to print out contents of $a0 as ascii
		syscall
		
		ror $t2, $t2, 8		# Rotate the contents of register $t2 to the right by 8 bits
		
		add $t1, $t1, 1		# increment For loop counter by 1

	j For

endFor:	


		
        li $v0,10       # eop
        syscall

        
		
		.data

display: 	.asciiz		"The hexidecimel number of 0x4D4D4154 is equal to my initials: \n"

			  ######### End Of Program_07.asm ##########

							#### Input ######
							#               #
							#  0x4D4D4154   #
							#               #
							#################			
			
			
			
					
################################# Output ##################################
#			               												  #
#                                                                         # 
#                                 TAMM                                    #
#														                  #
#			                                                              # 
###########################################################################