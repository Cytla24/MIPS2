# MIPS Programming Project 2 
# Aimie Ojuba - @02837763
.data

	Ask_Input: .asciiz "Please Enter a String\n"
	invalidinp: .asciiz "invalid input\n"
	input: .space 1000

.text
main:
	lui $t8, 43
	ori $t8, $t8, 19715
	add $t0, $zero, $t8				# int $t0 = 02837763
	addi $t1, $zero, 11				# int $t1 = 11
	div $t0, $t1					# divide t0/t1
	mfhi $t3						# remainder = t3
	addi $s0, $t3, 26				# N = s0
	addi $t9, $zero, 10
	sub $s1, $s0, $t9				# M = s1
	
	#display req for input
	li $v0, 4
	la $a0, Ask_Input
	syscall
	
	#input string
	li $v0, 8
	la $a0, input
	li $a1, 1000
	syscall
	
	#instantiate index to 0
	addi $t6, $zero, 0

	#declare final reg
	li $t4, 0
	
	#Finding first non space char
	li $t2, 0
floop:
	beq $t6, 996 , test
	
	#get each character
	la $a1, input
	addu $a1, $a1, $t6
	lb $a0, 0($a1)
	
	
	#branch if character is not a space or tab
	seq $t5, $a0, 0
	seq $t7,$a0, 32
	seq $t8,$a0, 9
	
	or $t7, $t5, $t7
	or $t7, $t7, $t8
	add $t2, $t6, $zero			#set t2 = first non space value 
	beq $t7, 0, inloop
	
	#print each index
	li $v0, 1
	addi $a0, $t6, 0
	syscall
	
	#increment index
	addi $t6, $t6, 1
	add $t2, $t6, $zero
	j floop

inloop:
	#loop from 4 characters ahead to check for invalid
	addi $t6, $t6, 4
	j lloop

lloop:	
	beq $t6, 1000, body 			#if index is at end of string, jump to body
	
	#get each character
	la $a1, input
	addu $a1, $a1, $t6
	lb $a0, 0($a1)
	
	#branch if character is not a space or tab
	seq $t5, $a0, 0
	seq $t9,$a0, 32
	seq $t8,$a0, 9
	
	or $t9, $t5, $t9
	or $t9, $t9, $t8 
	beq $t9, 0, invalid
	
	#print each index
	li $v0, 1
	addi $a0, $t6, 0
	syscall
	
	#increment index
	addi $t6, $t6, 1
	j lloop

test: 
	#set t3 = t2 + 3
	addi $t3, $t2, 3
	add $t6, $t2, $zero
	addi $t7, $t3, 1
test2:
	beq $t7, $t6, body
	
	j test2
body:
	
	j exit

	

invalid:
	#display invalid input
	li $v0, 4
	la $a0, invalidinp
	syscall	
	
exit:
	#End of Main
	li $v0,10
	syscall
