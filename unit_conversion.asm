.data

choice: .asciiz "Enter your conversion.\n1-Temperature.\n2-Length.\n3-Weight.\nYour Choice:>"

text1: .asciiz "Enter the temp unit you want to convert from:\n1-celsius.\n2-farenheit.\n3-Kelvin.\n\nyour choice: "
text2: .asciiz "\nTemperature: "
text3: .asciiz "\nEnter the temp unit you want to convert the temp into:\n1-celsius.\n2-farenheit.\n3-kelvin.\n\nyour choice: "

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

la $a0 choice
li $v0, 4
syscall
li $v0 5
syscall
move $s5 $v0

li $s6 1
li $s7 2
li $s8 3

beq $s5 $s6 L1
beq $s5 $s7 L2
beq $s5 $s8 L3

L1:
	la $a0, text1
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	move $t1, $v0

	la $a0, text2
	li $v0, 4
	syscall

	li $v0,6
	syscall
	mov.s $f2, $f0

	li $t3, 1
	li $t4, 2
	li $t5, 3

	beq $t1, $t3, celsius
	beq $t1, $t4, farenheit
	beq $t1, $t5, kelvin

farenheit:
	l.s $f3 d5
	l.s $f4 d6
	l.s $f5 d7

	sub.s $f2, $f2, $f5
	div.s $f2, $f2, $f3
	mul.s $f2, $f2, $f4
	j request

kelvin:
	l.s $f3, d8
	sub.s $f2, $f2, $f3
	j request

celsius:
	j request

request:
	la $a0, text3
	li $v0,4
	syscall

	li $v0, 5
	syscall
	move $t2, $v0

	beq $t2, $t3, celsiusfinal
	beq $t2, $t4, farenheitfinal
	beq $t2, $t5, kelvinfinal

celsiusfinal:
	la $a0, text2
	li $v0, 4
	syscall
	mov.s $f12, $f2
	li $v0, 2
	syscall
	j exit

farenheitfinal:
	l.s $f3 d5
	l.s $f4 d6
	l.s $f5 d7

	div.s $f4, $f3, $f4
	mul.s $f4, $f4, $f2
	add.s $f4, $f5, $f4
	
	la $a0, text2
	li $v0, 4
	syscall
	mov.s $f12, $f4
	li $v0, 2
	syscall
	j exit

kelvinfinal:
	l.s $f3 d8

	add.s $f2, $f2, $f3

	la $a0, text2
	li $v0, 4
	syscall
	mov.s $f12, $f2
	li $v0, 2
	syscall
	j exit

L2:
	la $a0, msg1
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t0 $v0
	 
	la $a0, msg2
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	mov.s $f2 $f0

	li $t1 1
	li $t2 2
	li $t3 3
	li $t4 4
	li $t5 5

	beq $t0 $t1 kilometer
	beq $t0 $t2 meter
	beq $t0 $t3 centimeter
	beq $t0 $t4 feet
	beq $t0 $t5 inch

meter:
	l.s $f3 d3
	div.s $f2 $f2 $f3
	j request1

centimeter:
	l.s $f3 d3 
	l.s $f4 d4
	div.s $f2 $f2 $f4
	div.s $f2 $f2 $f3
	j request1

feet:
	l.s $f3 d1
	l.s $f4 d3 
	l.s $f5 d4
	mul.s $f2 $f2 $f3
	div.s $f2 $f2 $f5
	div.s $f2 $f2 $f4
	j request1

inch:
	l.s $f3 d2
	l.s $f4 d1
	l.s $f5 d3 
	l.s $f6 d4
	div.s $f2 $f2 $f3
	mul.s $f2 $f2 $f4
	div.s $f2 $f2 $f6
	div.s $f2 $f2 $f5
	j request1

kilometer:
	j request1


request1:
	
	la $a0, msg3
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t6 $v0

	beq $t6 $t1 kilometerfinal 
	beq $t6 $t2 meterfinal
	beq $t6 $t3 centimeterfinal
	beq $t6 $t4 feetfinal
	beq $t6 $t5 inchfinal

kilometerfinal:
	la $a0, msg2
	li $v0, 4
	syscall
	mov.s $f12 $f2
	li $v0, 2
	syscall
	j exit

meterfinal:
	l.s $f3 d3
	la $a0, msg2
	li $v0, 4
	syscall
	mul.s $f2 $f2 $f3
	mov.s $f12 $f2
	li $v0 2
	syscall
	j exit

centimeterfinal:
	l.s $f3 d3
	l.s $f4 d4
	la $a0, msg2
	li $v0, 4
	syscall
	mul.s $f2 $f2 $f3
	mul.s $f2 $f2 $f4
	mov.s $f12 $f2
	li $v0 2
	syscall
	j exit

feetfinal:
	l.s $f3 d3
	l.s $f4 d4
	l.s $f5 d1
	la $a0, msg2
	li $v0, 4
	syscall
	mul.s $f2 $f2 $f3
	mul.s $f2 $f2 $f4
	div.s $f2 $f2 $f5
	mov.s $f12 $f2
	li $v0 2
	syscall
	j exit
	
inchfinal:
	l.s $f3 d3
	l.s $f4 d4
	l.s $f5 d1
	l.s $f6 d2
	la $a0, msg2
	li $v0, 4
	syscall
	mul.s $f2 $f2 $f3
	mul.s $f2 $f2 $f4
	div.s $f2 $f2 $f5
	mul.s $f2 $f2 $f6
	mov.s $f12 $f2
	li $v0 2
	syscall
	j exit


L3:
	la $a0, msg5
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	la $a0, msg2
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	mov.s $f2, $f0

	li $t2, 1
	li $t3, 2
	li $t4, 3
	li $t5, 4

	beq $t0, $t2, gram
	beq $t0, $t3, killogram
	beq $t0, $t4, ounce
	beq $t0, $t5, pound

gram:
	j request3

killogram:
	l.s $f3, d9
	mul.s $f2, $f2, $f3
	j request3

ounce:
	l.s $f3, d10
	mul.s $f2, $f2, $f3
	j request3

pound:
	l.s $f3, d11
	mul.s $f2, $f2, $f3
	j request3

request3:
	la $a0, msg6
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	move $t6, $v0

	beq $t6, $t2, gramfinal
	beq $t6, $t3, killogramfinal
	beq $t6, $t4, ouncefinal
	beq $t6, $t5, poundfinal

gramfinal:
	la $a0, msg2
	li $v0, 4
	syscall
	mov.s $f12, $f2
	li $v0, 2
	syscall
	j exit

killogramfinal:
	l.s $f3, d9
	div.s $f2, $f2, $f3
	la $a0, msg2
	li $v0, 4
	mov.s $f12, $f2
	li $v0, 2
	syscall
	j exit

ouncefinal:
	l.s $f3, d10
	div.s $f2, $f2, $f3
	la $a0, msg2
	li $v0, 4
	mov.s $f12, $f2
	li $v0, 2
	syscall
	j exit

poundfinal:
	l.s $f3, d11
	div.s $f2, $f2, $f3
	la $a0, msg2
	li $v0, 4
	mov.s $f12, $f2
	li $v0, 2
	syscall
	j exit	


exit:
	la $a0, msg4
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	li $t2, 2
	li $t3, 3
	li $t4, 1
	beq $t1, $t2, main
	beq $t1, $t3, exitfinal
	beq $t1, $t4, menu_choice

menu_choice:
	beq $s5, $s6, L1
	beq $s5, $s7, L2
	beq $s5, $s8, L3

exitfinal:
	li $v0, 10
	syscall