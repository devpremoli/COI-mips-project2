.data

prompt: .asciiz "Not recognized"
input: .space 1001
string: .space 5


.text

main:
li $v0, 8	# laoding call code 8 for reading string
la $a0, input	# loading the address of input
li $a1, 1001	# length of input
syscall

la $t1, input	#loading the address of input into $t1 register

li $s6, 0	# for storing the sum of decimal value of each valid base 27 number (2992540%11=1, so N=27 in my case)



storing:
lb $t0, ($t1)
addi $t1, $t1, 1
beq $t0, 10, label1	#branch if character is \n
beq $t0, 0, label2	#branch if character is null
beq $t0, 32, label3	#branch if character is space
beq $t0, 11, label	#branch if character is tab

# if any of the above branching is not executed, then the character is valid.
# Now storing the four characters to work with.

la $s1, string		#loading the address of string data into s1

lb $t0, -1($t1)
sb $t0, 0($s1)		#storing the first character in the first byte of $s6

lb $t0, 0($st1)
sb $t0, 1($t1)		#storing the second character in the second byte of $s6

lb $t0, 1($s1)
sb $t0, 2($t1)		#storing the third character


j storing
