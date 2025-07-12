	INIMIGO_TIPO_2:

		# Faz a periodizacao do movimento
			la s2, TEMPO_INICIAL_INIMIGOS
			lw t2, 0(s2)   # Pega TEMPO_INICIAL_INIMIGO i

			# Pega tempo atual
			li a7, 30           # Chama a funcao TIME()
			ecall               # Chama o Sistema operacional

			# Pega o tempo passado desde o tempo inicial
			sub t3, a0, t2			# t3 = TEMPO_ATUAL - TEMPO_INICIAL_TESTE

			# Faz as comparacoes de tempo serem de 250, 300, 350, 400
			li t2, 170
			blt t3, t2, FIM_ATUALIZA_TILEMAP # Se passou 1 segundo, reduza SCORE_TIMER
				# Atualiza TEMPO_INICIAL inimigo i
				li a7, 30   	# Chama a funcao TIME()
				ecall       	# Chama o Sistema operacional
				sw a0, 0(s2)	# Atualiza o conteudo de TEMPO_INICIAL inimigo i

		# MOVIMENTA PACMAN
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

			# Pega a esperada proxima posicao
			la s3, CAMINHO_PACMAN
			li t4, 2
			mul t4, t3, t4
			add s3, s3, t4
			lh s3, 0(s3)

			# VERIFICA COLISOES
				# Colisao com personagem
				la s4, POSICAO_JOGADOR
				lw s4, 0(s4)
				bne s3, s4, COLISAO_BOMBA
					# Reduz vida em 1
					la t2, VIDAS
					lw t4, 0(t2)
					addi t4, t4, -1
					sw t4, 0(t2)
					j ATUALIZA_CAMINHO

				# Colisao com bomba
				COLISAO_BOMBA:
					la s4, POSICAO_BOMBA
					lw s4, 0(s4)
					bne s3, s4, ATUALIZA_CAMINHO
					j INVERTE_OFFSET

				# # Colisao com pilastra
				# COLISAO_TILEMAP:
				# 	lw s1, TILEMAP_MUTAVEL
				# 	add s1, s1, s3
				# 	lb s4, 0(s1)

				# 	li t2, 1
				# 	beq s4, t2, INVERTE_OFFSET

				# 	# Colisao com tijolo 
				# 	li t2, 3
				# 	beq s4, t2, INVERTE_OFFSET
				# 	j ATUALIZA_CAMINHO

				# Inverte direcao de deslocamento no caminho do PACMAN
				INVERTE_OFFSET:
					li t2, -1
					mul t1, t1, t2
					sb t1, 0(s6)
					j FIM_ATUALIZA_TILEMAP


			# Pega Nova_posicao no vetor Caminho
			ATUALIZA_CAMINHO:
				# Atualiza Posicao caminho
				sb t3, 0(s5)

				# Atualiza POSICAO DE RENDERIZACAO/COLISAO do PACMAN

            # Atualiza sprite
				la s6, POSICAO_INIMIGOS
                lw t0, 0(s6)            # Pega posicao atual
                sw s3, 0(s6)            # Atualiza posicao atual para nova posicao

                sub t0, s3, t0          # Pega salto da posicao atual para a nova
                la t5, IMAGEM_INIMIGOS  # Pega endereco inicial do vetor de imagens de inimigos
                # Switch Sprites
                li t2, -20
                bne t0, t2, PACMAN_ESQUERDA
                la t1, IMAGEM_PAC_MAN_CIMA
                sw t1, 0(t5)	# Imagem do primeiro inimigo
                j FIM_ATUALIZA_TILEMAP

                PACMAN_ESQUERDA:
                li t2, -1
                bne t0, t2, PACMAN_BAIXO
                la t1, IMAGEM_PAC_MAN_ESQUERDA
                sw t1, 0(t5)	# Imagem do primeiro inimigo
                j FIM_ATUALIZA_TILEMAP

                PACMAN_BAIXO:
                li t2, 20
                bne t0, t2, PACMAN_DIREITA
                la t1, IMAGEM_PAC_MAN_BAIXO
                sw t1, 0(t5)	# Imagem do primeiro inimigo
                j FIM_ATUALIZA_TILEMAP

                PACMAN_DIREITA:
                la t1, IMAGEM_PAC_MAN_DIREITA
                sw t1, 0(t5)
