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
li $t4, 0						# loop counter for four charcters stored in $s1.
li $t8, 0
li $t3, 1						# intializing the power



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

handling:			#after four characters has been stored to $s1 register, now $s1 is handeled in this handling label.
beq $t4, 4, unfind
addi t4, $t4, 1
addi $s1, $s1, 1
lb $t0, ($s1)

checker:		# a label where a character in $t0 is checked if it is valid or not

bge $t0, 97, lowercase
bge $t0, 65, uppercase
bge $t0, 48, number


number:
bgt $t0, 57, error
ble $t0, 57, num

lowercase:
bgt $t0, 113, error
ble $t0, 113, lcase

uppercase:
bgt $t0, 81, error
ble $t0, 81, ucase

num:
addi $a0, $t0, -48
j conversion

ucase:
addi $a0, $t0, -55
j conversion

lcase:
addi $a0, $t0, -87
j conversion


conversion:
mul $a2, $a0, $t3
add $s6, $a2, $zero



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


