.data 
	GERTRUDE: .string "GERTRUDE\n"
	G: .ascii "G"
	
.text 
	li t0, 71
	la t1, G
	lb t1, 0(t1)
	beq t0, t1, PRINTA
	li a7, 10
	ecall

PRINTA:	
	la a0, GERTRUDE
	li a7, 4
	ecall
	li a7, 10
	ecall