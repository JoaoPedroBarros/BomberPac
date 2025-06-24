	la t0, SCORE_TIMER  # Pega o endereco de SCORE_TIMER
	lw t0, 0(t0)        # Pega o conteudo de SCORE_TIMER
	beqz t0, FIM_GAME_LOOP_FASE_1   # Se SCORE_TIMER == 0 -> Encerre a Fase

	# Pega tempo em TEMPO_INICIAL_SCORE_TIMER
	la s2, TEMPO_INICIAL_SCORE_TIMER	# Pega endereco de TEMPO_INICIAL_SCORE_TIMER
	lw s2, 0(s2)                        # Pega o conteudo de TEMPO_INICIAL_SCORE_TIMER

	# Pega tempo atual
	li a7, 30           # Chama a funcao TIME()
	ecall               # Chama o Sistema operacional

	# Pega o tempo passado desde o tempo inicial
	sub t3, a0, s2			# t3 = TEMPO_ATUAL - TEMPO_INICIAL_TESTE

	li t2, 1000     # Constante de comparacao : 1 segundo
	blt t3, t2, PULA_REDUZ_TIMER # Se passou 1 segundo, reduza SCORE_TIMER	
	
	# REDUZ_TIMER : SCORE_TIMER--
	la t0, SCORE_TIMER      # Pega o endereco de SCORE_TIMER
	lw t1, 0(t0)            # Pega o conteudo de SCORE_TIMER
	addi t1, t1, -1         # Subtrai 1 segundo de SCORE_TIMER
	sw t1, 0(t0)            # Atualiza a variavel SCORE_TIMER
	
	# Atualiza TEMPO_INICIAL_SCORE_TIMER
	li a7, 30   # Chama a funcao TIME()
	ecall       # Chama o Sistema operacional
	
	la s2, TEMPO_INICIAL_SCORE_TIMER    # Pega endereco de TEMPO_INICIAL_SCORE_TIMER
	sw a0, 0(s2)                        # Atualiza o conteudo de TEMPO_INICIAL_SCORE_TIMER

PULA_REDUZ_TIMER:	