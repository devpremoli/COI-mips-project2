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