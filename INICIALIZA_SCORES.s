	# Inicializa SCORE_TIMER
	la t0, SCORE_TIMER
	li t1, 101
	sw t1, 0(t0)

	# Inicializa VIDAS
	la t0, VIDAS
	li t1, 3
	sw t1, 0(t0)

	# Inicializa PONTOS
	la t0, PONTOS
	li t1, 0
	sw t1, 0(t0)
