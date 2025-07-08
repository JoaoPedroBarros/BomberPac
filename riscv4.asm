.data
	quebra: .ascii "\n"
	
.text
	li a7, 1
	la a0, quebra
	lb a0, 0(a0)
	ecall