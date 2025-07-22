##################################################################
############# RENDERIZA COMPLETAMENTE O CAMPO ##################
##################################################################
INICIO_CAMPO:
	li t0, 41		    # Primeira matriz do CAMPO
	li s6, 278		    # Ultima matriz do tilemap
# Loop que percorre todo o Tilemap. Da esquerda para direita, de cima para baixo e byte a byte.
LOOP_TILEMAP_CAMPO:
	bgt t0, s6, FIM_CAMPO		# Enquanto t0 < ultima matriz do tilemap, faca o abaixo

		# Pega valor da posicao atual no Tilemap
		lw s2, TILEMAP_MUTAVEL	# Pegue o endereco do Tilemap
		add s2, s2, t0	# Itere o endereco do byte no tilemap
		lb t5, 0(s2)	# Valor da matriz no Tilemap

		# Os casos abaixos pegam a imagem que deve ser printada
		CASO_0_CAMPO:
				li t2, 0		# Pegue o valor 0
				bne t5, t2, CASO_1_CAMPO	# Compare com o valor no byte atual do Tilemap
				la t5, IMAGEM_0		# Se o byte atual == 0, pegue a imagem_0
				j PREENCHE_MATRIZ_CAMPO	# Printa a matriz do byte atual
		CASO_1_CAMPO:
				li t2, 1		# Pegue o valor 0										
				bne t5, t2, CASO_2_CAMPO	# Compare com o valor no byte atual do Tilemap
				la t5, IMAGEM_1		# Se o byte atual == 1, pegue a imagem_1
				j PREENCHE_MATRIZ_CAMPO	# Printa a matriz do byte atual
		CASO_2_CAMPO:
				li t2, 2		# Pegue o valor 0
				bne t5, t2, CASO_3_CAMPO	# Compare com o valor no byte atual do Tilemap
				la t5, IMAGEM_2		# Se o byte atual == 2, pegue a imagem_2
				j PREENCHE_MATRIZ_CAMPO	# Printa a matriz do byte atual		
		CASO_3_CAMPO:
				li t2, 3		# Pegue o valor 0
				bne t5, t2, CASO_5_CAMPO	# Compare com o valor no byte atual do Tilemap
				la t5, IMAGEM_3		# Se o byte atual == 2, pegue a imagem_2
				j PREENCHE_MATRIZ_CAMPO	# Printa a matriz do byte atual		
		CASO_5_CAMPO:
				li t2, 5		# Pegue o valor 0
				bne t5, t2, CASO_6_CAMPO	# Compare com o valor no byte atual do Tilemap
				la t5, IMAGEM_PODER_CHUTE		# Se o byte atual == 2, pegue a imagem_2
				j PREENCHE_MATRIZ_CAMPO	# Printa a matriz do byte atual		
		CASO_6_CAMPO:
				li t2, 6		# Pegue o valor 0
				bne t5, t2, CASO_7_CAMPO	# Compare com o valor no byte atual do Tilemap
				la t5, IMAGEM_PODER_FORCA		# Se o byte atual == 2, pegue a imagem_2
				j PREENCHE_MATRIZ_CAMPO	# Printa a matriz do byte atual				
		CASO_7_CAMPO:
				li t2, 7		# Pegue o valor 0
				bne t5, t2, CASO_8_CAMPO	# Compare com o valor no byte atual do Tilemap
				
				# Se Chute estiiver ativo
				la t2, BOOLEANO_CHUTE
				lb t2, 0(t2)
				beqz t2, BOMBA_NORMAL
				la t5, bomba_chute
				j PREENCHE_MATRIZ_CAMPO	# Printa a matriz do byte atual				

				BOMBA_NORMAL:
				la t5, bomba		# Se o byte atual == 2, pegue a imagem_2
				j PREENCHE_MATRIZ_CAMPO	# Printa a matriz do byte atual				
		CASO_8_CAMPO:
				li t2, 8		# Pegue o valor 0
				bne t5, t2, ITERA_LOOP_TILEMAP_CAMPO 	# Compare com o valor no byte atual do Tilemap
				la t5, ponto		# Se o byte atual == 2, pegue a imagem_2	

		PREENCHE_MATRIZ_CAMPO:
			call RenderizacaoDinamica

		# Etapa de iteracao do byte no Tilemap		
		ITERA_LOOP_TILEMAP_CAMPO:
				addi t0, t0, 1	# t0++
				li s4, 20       # s4 = 20
				rem s4, t0, s4  # s4 = t0 % 20
				li s5, 19       # s5 = 19
				bne s4, s5, LOOP_TILEMAP_CAMPO # Se s4 != 19 -> LOOP_TILEMAP_CAMPO
				addi t0, t0, 2  # s4 == 19 -> Some 2 : Pule colunas indestrutiveis
				j LOOP_TILEMAP_CAMPO # Retorne para a verificacao do Loop que percorre o Tilemap

# Fim_CAMPO do programa
FIM_CAMPO:
