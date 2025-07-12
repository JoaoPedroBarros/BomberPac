.data
	OFFSET_INIMIGOS: .byte 1
	POSICAO_CAMINHO: .byte 0
	TAM_CAMINHO_PACMAN: .byte 56
	CAMINHO_PACMAN: .half 
	42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58,
	78, 98, 118, 138, 158, 178, 198, 218, 238, 258, 278, 
	277, 276, 275, 264, 273, 272, 271, 270, 269, 268, 267, 266, 265, 264, 263, 262, 261,
	241, 221, 201, 181, 161, 141, 121, 101, 81, 61, 41
	
	Quebra: .string "\n"

.text
LOOP:
	# Pega indice atual
	la s5, POSICAO_CAMINHO
	lb t0, 0(s5)

	# Pega Offset atual
	la s6, OFFSET_INIMIGOS
	lb t1, 0(s6)

	# Pega tamanho do vetor Caminho
	la t2, TAM_CAMINHO_PACMAN
	lb t2, 0(t2)

	# Monta Novo_indice = (indice_atual + offset + tamanho) % tamanho
	add t3, t0, t1
	add t3, t3, t2
	rem t3, t3, t2

	# Atualiza Posicao caminho
	sb t3, 0(s5)

	# Pega Nova_posicao no vetor Caminho
	la s5, CAMINHO_PACMAN
	li t4, 2
	mul t4, t3, t4
	add s5, s5, t4
	lh s5, 0(s5)

	mv a0, s5
	li a7, 1
	ecall
	
	la a0, Quebra
	li a7, 4
	ecall
	
	li a0, 100
	li a7, 32
	ecall
	
	j LOOP
