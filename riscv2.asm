.data

.text
	li s0, 3000
	call Espera
	li a7, 10
	ecall

Espera:
	li a7, 30
	ecall
	add s0, a0, s0
	LoopEspera:
		bgt a0, s0, FimEspera
			li a7, 30
			ecall
		j LoopEspera
FimEspera:
	ret