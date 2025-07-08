# Existe um bug de colisao dupla. Provavelmente devido aa movimentacao acelerada do personagem	
	########################
	## LOOP CHECKAR BOMBA ##
	########################

	la t4, POSICAO_BOMBA		# Verifica se tem uma bomba
	lw t0, 0(t0)
	 
	li s2, 0
		beq t0, s2, SWITCH_LETRAS	
		la t2, SCORE_TIMER		# Inicializa SCORE_TIMER e TEMPO_INICIAL_BOMBA para comparar
		lw t2, 0(t2)
		la s2, TEMPO_INICIAL_BOMBA
		lw s2, 0(s2)

		# Verifica se a bomba ja pode explodir
		addi s2, s2, -2				# Se ja passou 2 segundos
		blt s2, t2, SWITCH_LETRAS
		addi t0, t0, -21


		li s2, 0				# Inicializa contador de blocos para iterar
		LOOP_DESTROI_BLOCO:
	
			addi s2, s2, 1

			lw s1, TILEMAP_MUTAVEL  # Pegue endereco inicial do TILEMAP
			add s1, s1, t0          # Pegue endereco da matriz ao redor da bomba
			lb s3, 0(s1)            # Pegue conteudo da matriz

            # Confere se ha inimigos no raio da explosao
			li s6, 0
			la s5, POSICAO_INIMIGOS
			la s8, QUANTIDADE_DE_INIMIGOS
			lb s8, 0(s8)
			LOOP_CONFERE_INIMIGOS_EXPLOSAO:
				beq s6, s8, VERIFICA_TIJOLOS
					lw t3, 0(s5)	# Pegue posicao do inimigo i

                    # Se posicao inimigo i for diferente do valor da area de explosao, ignore
                    bne t0, t3, ITERA_CONFERE_INIMIGOS_EXPLOSAO
                        # Posicao inimigo = 0 : Sinonimo de inimigo morto
                        li t2, 0
                        sw t2, 0(s5)

					ITERA_CONFERE_INIMIGOS_EXPLOSAO:
						addi s6, s6, 1	# Itera contador
						addi s5, s5, 4	# Itera Vetor Posicao inimigos
						j LOOP_CONFERE_INIMIGOS_EXPLOSAO

            VERIFICA_TIJOLOS:
			li t2, 3	
			beq s3, t2, EXPLODE_BLOCO	# Se o espaco checado eh um tijolo pula pra EXPLODE_BLOCO
			
			li t2, 8                          
			bne s3, t2, ITERA_EXPLOSAO    # Nova posicao disponivel para colocar bomba (Vazio)
			
			la t1, PONTOS
			lw t2, 0(t1)
			addi t2, t2, 1
			sw t2, 0(t1)
			
			li t2, 0
			sb t2, 0(s1)

			ITERA_EXPLOSAO:
				li t2, 3
				rem t2, s2, t2
				li t3, 0
				beq t2, t3, PROX_LINHA		# Se o indice atual passou de linha pula pra PROX_LINHA
			
				addi t0, t0, 1		# Vai para a proxima posicao
				j LOOP_DESTROI_BLOCO


		EXPLODE_BLOCO:
			li s4, 40
			call DestroiTijolo		# Quebra o bloco

			li t2, 3
			rem t2, s2, t2
			li t3, 0
			beq t2, t3, PROX_LINHA		# Se o indice atual passou de linha pula pra PROX_LINHA

			addi t0, t0, 1
			j LOOP_DESTROI_BLOCO
		
		PROX_LINHA:
			li t2, 9
			beq s2, t2, DELETA_BOMBA	# Se a bomba nao acabou de checar
			addi t0, t0, 18				# Vai para a proxima linha
			j LOOP_DESTROI_BLOCO
		
		DELETA_BOMBA:
			addi t0, t0, -21			# Centraliza a posicao para onde a bomba fica
			
			lw s1, TILEMAP_MUTAVEL		# Inicializa TILEMAP_MUTAVEL
			add s1, s1, t0				# s1 += posicao da bomba

			li t2, 0
			sb t2, 0(s1)
			
			la t0, POSICAO_BOMBA		# Verifica se tem uma bomba
			sw t2, 0(t0)

