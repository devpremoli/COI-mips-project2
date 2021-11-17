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
