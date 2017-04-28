.data

choice: .asciiz "Enter your conversion.\n1-Temperature.\n2-Length.\n3-Weight.\nYour Choice:>"

text1: .asciiz "Enter the temp unit you want to convert from:\n1-celsius.\n2-fahrenheit.\n3-Kelvin.\n\nyour choice: "
text2: .asciiz "\nTemperature: "
text3: .asciiz "\nEnter the temp unit you want to convert the temp into:\n1-celsius.\n2-fahrenheit.\n3-kelvin.\n\nyour choice: "

msg1: .asciiz "Enter the unit you want to convert from:\n1-Kilometer.\n2-Meter.\n3-Centimeter.\n4-Feet.\n5-Inch\n\nYour choice:>"
msg2: .asciiz "\nvalue:"
msg3: .asciiz "\nEnter your choice you want to convert the unit into:\n1-Kilometer.\n2-Meter.\n3-Centimeter.\n4-Feet.\n5-Inch.\n\nYour choice:>"

msg4: .asciiz "\nMenu:\n(1)Convert another one\n(2)Go Back\n(3)Exit\nYour Choice: "

msg5: .asciiz "Enter the unit you want to convert from:\n(1)grams\n(2)killograms\n(3)ounces\n(4)pounds\nyour choice:  "
msg6: .asciiz "Enter the unit you want to convert to:\n(1)grams\n(2)killograms\n(3)ounces\n(4)pounds\nyour choice:  "


d1: .float 30.0
d2: .float 12.0
d3: .float 1000.0
d4: .float 100.0
d5: .float 9.0
d6: .float 5.0
d7: .float 32.0
d8: .float 273.15
d9: .float 1000.0
d10: .float 28.34952
d11: .float 453.592

.text

main:

la $a0 choice 				# prompts the user to select the desired unit of conversion (temp, length, weight)
li $v0, 4
syscall
li $v0 5 					# gets the option from the user
syscall
move $s5 $v0 				# $s5=option

li $s6 1 					# $s6 = 1
li $s7 2 					# $s7 = 2
li $s8 3 					# $s8 = 3

beq $s5 $s6 L1 				# compares $s5 and $s6
beq $s5 $s7 L2 				# compares $s5 and $s7
beq $s5 $s8 L3 				# compares $s5 and $s8



		# if temperature is selected 	

L1: 									
	la $a0, text1 			# prompts the user to select the unit ot temp (celsius, fahrenheit, kelvin)
	li $v0, 4
	syscall

	li $v0, 5 				# get the option from user
	syscall
	move $t1, $v0 			# $t1 = option

	la $a0, text2 			# prompts the user to input the temperature, he/she wants to convert 
	li $v0, 4
	syscall

	li $v0,6 				# get the temperature
	syscall
	mov.s $f2, $f0 			# $f2 = tempertaure 


		# converts any given temperature unit to celsius

	li $t3, 1 				# $t3 = 1
	li $t4, 2 				# $t4 = 2
	li $t5, 3 				# $t5 = 3

	beq $t1, $t3, celsius 		# compares $t1 and $t3
	beq $t1, $t4, fahrenheit 	# compares $t1 and $t4
	beq $t1, $t5, kelvin 		# compares $t1 and $t5

fahrenheit: 					# converts fahrenheit to celsius
	l.s $f3 d5 				# $f3 = 9.0
	l.s $f4 d6 				# $f4 = 5.0
	l.s $f5 d7 				# $f5 = 32.0

	sub.s $f2, $f2, $f5 	# $f2 = $f2 - $f5
	div.s $f2, $f2, $f3 	# $f2 = $f2 / $f3
	mul.s $f2, $f2, $f4 	# $f2 = $f2 * $f4
	j request 				# go to loop request

kelvin: 					# converts kelvin to celsius
	l.s $f3, d8 			# $f3 = 273.18
	sub.s $f2, $f2, $f3 	# $f2 = $f2 - $f3
	j request 				# go to loop request

celsius:
	j request 				# go to loop request

request: 					# asks the user to input the unit they want to convert into
	la $a0, text3 			# prompts the user to select the unit ot temp (celsius, fahrenheit, kelvin)
	li $v0,4
	syscall

	li $v0, 5 				# get the option from the user
	syscall
	move $t2, $v0 			# $t2 = option

	beq $t2, $t3, celsiusfinal    		# compares $t1 with $t3
	beq $t2, $t4, fahrenheitfinal 		# compares $t1 with $t4
	beq $t2, $t5, kelvinfinal 			# compares $t1 with $t5

		

celsiusfinal: 				#converts celsius to celsius		
	la $a0, text2			# display "temperature:"
	li $v0, 4
	syscall
	mov.s $f12, $f2
	li $v0, 2 				# display converted temperature
	syscall
	j exit 					# jump to exit for menu


		

fahrenheitfinal: 			#converts celsius to fahrenheit
	l.s $f3 d5 				# $f3 = 9.0
	l.s $f4 d6				# $f4 = 5.0
	l.s $f5 d7 				# $f5 = 32.0

	div.s $f4, $f3, $f4 	# $f4 = $f3 / $f4
	mul.s $f4, $f4, $f2 	# $f4 = $f4 * $f2
	add.s $f4, $f5, $f4 	# $f4 = $f4 + $f4
	
	la $a0, text2 			# display "tmeperature: "
	li $v0, 4
	syscall
	mov.s $f12, $f4
	li $v0, 2 				# display converted temperature
	syscall
	j exit


		

kelvinfinal:				# converts celsius to kelvin
	l.s $f3 d8 				# $f3 = 273.15

	add.s $f2, $f2, $f3 	# $f2 = $f2 + $f3

	la $a0, text2 			# display "temperature: "
	li $v0, 4
	syscall
	mov.s $f12, $f2
	li $v0, 2 				# display converted temperature
	syscall
	j exit 					# jump to exit for menu


		# if length is selected

L2:
	la $a0, msg1 			# prompts the user to select the unit ot length (killometer, meter, centimeter, feet, inch)
	li $v0, 4
	syscall
	li $v0, 5 				# get the option selected by the user
	syscall
	move $t0 $v0 			# $t0 = option
	 
	la $a0, msg2 			# gets the value that is to be converted
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	mov.s $f2 $f0

	li $t1 1 			# $t1 = 1
	li $t2 2 			# $t2 = 2
	li $t3 3 			# $t3 = 3
	li $t4 4 			# $t4 = 4
	li $t5 5 			# $t5 = 5

	beq $t0 $t1 kilometer 		# compares $t0 and $t1
	beq $t0 $t2 meter 			# compares $t0 and $t2
	beq $t0 $t3 centimeter 		# compares $t0 and $t3
	beq $t0 $t4 feet 			# compares $t0 and $t4
	beq $t0 $t5 inch 			# compares $t0 and $t5

meter: 						# converts meter to killometer
	l.s $f3 d3 				# $f3 = 1000.0
	div.s $f2 $f2 $f3 		# $f2 = $f2 / $f3
	j request1 				# go to loop request1

centimeter: 				#converts centimeter to killometer
	l.s $f3 d3  			# $f3 = 1000.0
	l.s $f4 d4 				# $f4 = 100.0
	div.s $f2 $f2 $f4 		# $f2 = $f2 / $f4
	div.s $f2 $f2 $f3 		# $f2 = $f2 / $f3
	j request1 				# go to loop request1

feet:						# converts feet to killometer
	l.s $f3 d1 				# $f3 = 30.0
	l.s $f4 d3  			# $f4 = 1000.0
	l.s $f5 d4 				# $f5 = 100.0
	mul.s $f2 $f2 $f3 		# $f2 = $f2 * $f2
	div.s $f2 $f2 $f5 		# $f2 = $f2 / $f5
	div.s $f2 $f2 $f4 		# $f2 = $f2 / $f4
	j request1 				# go to loop request1

inch: 						#converts inches to killometer
	l.s $f3 d2 				# $f3 = 12.0
	l.s $f4 d1 				# $f4 = 30.0
	l.s $f5 d3 				# $f5 = 1000.0
	l.s $f6 d4 				# $f6 = 100.0
	div.s $f2 $f2 $f3 		# $f2 = $f2 / $f3
	mul.s $f2 $f2 $f4		# $f2 = $f2 * $f4
	div.s $f2 $f2 $f6  		# $f2 = $f2 / $f6
	div.s $f2 $f2 $f5 		# $f2 = $f2 / $f5
	j request1				# go to loop request1

kilometer:
	j request1				# go to loop request1 


request1: 					# asks the user to input the unit they want to convert into
	
	la $a0, msg3 			# prompts the user to select the unit ot length (killometer, meter, centimeter, feet, inch)
	li $v0, 4
	syscall
	li $v0, 5				# get the option selected by the user
	syscall
	move $t6 $v0 			# $t6 = option

	beq $t6 $t1 kilometerfinal  		# compares $t6 and $t1
	beq $t6 $t2 meterfinal				# compares $t6 and $t2
	beq $t6 $t3 centimeterfinal 		# compares $t6 and $t3
	beq $t6 $t4 feetfinal 				# compares $t6 and $t4
	beq $t6 $t5 inchfinal 				# compares $t6 and $t5

kilometerfinal:				# converts killometer to killometer
	la $a0, msg2 			# display "value"
	li $v0, 4
	syscall
	mov.s $f12 $f2
	li $v0, 2 				# display the converted value
	syscall
	j exit 					# go to exit loop for menu

meterfinal: 				# converts killometer to meter
	l.s $f3 d3 				# $f3 = 1000.0
	la $a0, msg2 			
	li $v0, 4 				# display "value"
	syscall
	mul.s $f2 $f2 $f3 		# $f2 = $f2 * $f3
	mov.s $f12 $f2 			
	li $v0 2 				# display the converted value
	syscall
	j exit 					# go to exit loop for menu

centimeterfinal: 			# converts killometer to centimeter
	l.s $f3 d3 				# $f3 = 1000.0
	l.s $f4 d4 				# $f4 = 100.0
	la $a0, msg2 			
	li $v0, 4 				# display "value"
	syscall
	mul.s $f2 $f2 $f3 		# $f2 = $f2 * $f3
	mul.s $f2 $f2 $f4 		# $f2 = $f2 * $f4
	mov.s $f12 $f2 			
	li $v0 2 				# display the converted value
	syscall
	j exit 					# go to exit loop for menu

feetfinal: 					# converts killometer to feet
	l.s $f3 d3 				# $f3 = 1000.0
	l.s $f4 d4 				# $f4 = 100.0
	l.s $f5 d1 				# $f5 = 30.0
	la $a0, msg2
	li $v0, 4 				# display "value"
	syscall
	mul.s $f2 $f2 $f3 		# $f2 = $f2 * $f3
	mul.s $f2 $f2 $f4 		# $f2 = $f2 * $f4
	div.s $f2 $f2 $f5 		# $f2 = $f2 / $f5
	mov.s $f12 $f2
	li $v0 2 				# display the converted value
	syscall
	j exit 					# go to the exit loop for menu
	
inchfinal: 				    # converts killometer to inches
	l.s $f3 d3 				# $f3 = 1000.0
	l.s $f4 d4 				# $f4 = 100.0
	l.s $f5 d1 				# $f5 = 30.0
	l.s $f6 d2 				# $f6 = 12.0
	la $a0, msg2
	li $v0, 4 				# display "value: "
	syscall
	mul.s $f2 $f2 $f3 		# $f2 = $f2 * $f3
	mul.s $f2 $f2 $f4 		# $f2 = $f2 * $f4
	div.s $f2 $f2 $f5 		# $f2 = $f2 / $f5
	mul.s $f2 $f2 $f6 		# $f2 = $f2 * $f6
	mov.s $f12 $f2 			
	li $v0 2 				# display converted value
	syscall
	j exit 					# go to exit loop for menu


		# if weight is selected

L3:
	la $a0, msg5 			# prompts the user to select the unit ot weight (gram, killogram, ounces, pounds)
	li $v0, 4
	syscall
	li $v0, 5 				# get the option selected by the user 
	syscall
	move $t0, $v0
	la $a0, msg2 			# gets the value that is to be converted
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	mov.s $f2, $f0

	li $t2, 1 				# $t2 = 1
	li $t3, 2 				# $t3 = 2
	li $t4, 3 				# $t4 = 3
	li $t5, 4 				# $t5 = 4

	beq $t0, $t2, gram 			# compares $t0 with $t2
	beq $t0, $t3, killogram 	# compares $t0 with $t3
	beq $t0, $t4, ounce 		# compares $t0 with $t4
	beq $t0, $t5, pound 		# compares $t0 with $t5

gram:
	j request3 			# go to loop request3

killogram: 					# converts killogram to grams
	l.s $f3, d9 			# $f3 = 1000.0
	mul.s $f2, $f2, $f3 	# $f2 = $f2 * $f3
	j request3 				# go to loop request3

ounce: 						# converts ounces to grams
	l.s $f3, d10  			# $f3 = 28.34952
	mul.s $f2, $f2, $f3 	# $f2 = $f2 * $f3
	j request3 				# go to loop request3

pound: 						# converts pounds to grams
	l.s $f3, d11            # $f3 = 453.592
	mul.s $f2, $f2, $f3 	# $f2 = $f2 * $f3
	j request3 				# go to loop request3

request3: 					# asks the user to input the unit they want to convert into
	la $a0, msg6 			
	li $v0, 4 				# prompts the user to select the unit ot weight (gram, killogram, ounces, pounds)
	syscall

	li $v0, 5 				# gets the option
	syscall
	move $t6, $v0 			# $t6 = option

	beq $t6, $t2, gramfinal 		# compares $t6 with $t2
	beq $t6, $t3, killogramfinal	# compares $t6 with $t3
	beq $t6, $t4, ouncefinal		# compares $t6 with $t4
	beq $t6, $t5, poundfinal		# compares $t6 with $t5

gramfinal: 					# converts gram to gram
	la $a0, msg2
	li $v0, 4 				# display "value"
	syscall
	mov.s $f12, $f2
	li $v0, 2 				# display converted value
	syscall
	j exit 					# goto the exit loop for menu

killogramfinal:				# converts gram to killogram
	l.s $f3, d9 			# $f3 = 1000.0
	div.s $f2, $f2, $f3		# $f2 = $f2 / $f3
	la $a0, msg2
	li $v0, 4 				# display "value"
	mov.s $f12, $f2
	li $v0, 2 				# display converted value
	syscall
	j exit 					# go to exit loop for menu

ouncefinal: 				# converts killogram to ounce
	l.s $f3, d10 			# $f3 = 28.34952
	div.s $f2, $f2, $f3 	# $f2 = $f2 / $f3
	la $a0, msg2
	li $v0, 4 				# display "value"
	mov.s $f12, $f2
	li $v0, 2 				# display converted value 
	syscall
	j exit 					# go to exit loop for menu

poundfinal: 				# converts killogram to to pound
	l.s $f3, d11 			# $f3 = 453.592
	div.s $f2, $f2, $f3 	# $f2 = $f2 / $f3
	la $a0, msg2
	li $v0, 4 				# display "value"
	mov.s $f12, $f2
	li $v0, 2 				# display converted value
	syscall
	j exit	 				# go to exit loop for menu


exit:
	la $a0, msg4
	li $v0, 4 					# print menu
	syscall
	li $v0, 5 					# get the choice
	syscall
	move $t1, $v0
	li $t2, 2 					# $t2 = 2
	li $t3, 3 					# $t3 = 3
	li $t4, 1 					# $t4 = 1
	beq $t1, $t2, main 			# compares $t1 and $t2 
	beq $t1, $t3, exitfinal 	# compares $t1 and $t3
	beq $t1, $t4, menu_choice 	# compares $t1 and $t4

menu_choice:
	beq $s5, $s6, L1 		# compares $s5 and $s6
	beq $s5, $s7, L2 		# compares $s5 and $s7
	beq $s5, $s8, L3 		# compares $s5 and $s8

exitfinal:
	li $v0, 10 				# terminates the program
	syscall