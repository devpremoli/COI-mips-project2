.data

prompt: .asciiz "Not recognized"
input: .space 1001
string: .space 5


.text

main:
li $v0, 8						# laoding call code 8 for reading string
la $a0, input						# loading the address of input
li $a1, 1001						# length of input
syscall

la $t1, input						#loading the address of input into $t1 register

li $s6, 0						# for storing the sum of decimal value of each valid base 27 number (2992540%11=1, so N=27 in my case)

li $t8, 0



storing:
lb $t0, ($t1)
addi $t1, $t1, 1
beq $t0, 10, ender					#branch if character is \n
beq $t0, 0, ender					#branch if character is null
beq $t0, 32, storing					#branch if character is space
beq $t0, 11, storing					#branch if character is tab

beq $t8, 1, exit					# if this instruction is reached, valid character is found
li $t8, 1

la $s1, string						#loading the address of string data into s1

lb $t0, -1($t1)
sb $t0, 0($s1)						#storing the first character in the first byte of $s6

lb $t0, 0($t1)
sb $t0, 1($s1)						#storing the second character in the second byte of $s6

lb $t0, 1($t1)
sb $t0, 2($s1)						#storing the third character

lb $t0, 2($t1)
sb $t0, 3($s1)						#storing the fourth character

addi $t1, $t1, 3					# incrementing 3 for three character stored.


ender:	# if null or end line is found we want to end the storing loop. so branching to this label whenever null or end line is found
beq $t8, 0, error
la $s1, string+4		#to start from the end character

printing:
li $v0, 4
la $a0, string
syscall

error:
li $v0, 4
la $a0, prompt
syscall

exit:
li $v0, 10
syscall


