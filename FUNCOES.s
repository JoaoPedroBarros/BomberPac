# O intuito dessas funcoes eh diminuir o codigo para evitar problemas de salto (j, call)

# s0 = Tempo de espera em milisegundos (Valor deve ser nao negativo)
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
	
######################################################
######## FUNCAO 1 #####################
######################################################
# s3 = Numero a ser printado
PRINTA_ALGARISMOS:
		# Excecao para generalizar a funcao e 
		# a reutilizar para imprimir pontos
		bnez s3, LOOP_PRINTA_ALGARISMOS
		li s2, 0
		addi t0, t0, -1
		j CASO_ALGARISMO_0

	LOOP_PRINTA_ALGARISMOS:
		addi t0, t0, -1
		beqz s3, FIM_PRINTA_ALGARISMOS
		li t3, 10
		rem s2, s3, t3	# Pega o alagrismo desejado
		sub s3, s3, s2	# Subtrai as unidades
		div s3, s3, t3	# Deixa somente as dezenas e centenas

		CASO_ALGARISMO_0:
			li t3, 0		                   # Pegue o valor 0
			bne s2, t3, CASO_ALGARISMO_1	   # Compare com o valor no byte atual do Tilemap
			la t5, NUMERO_0		               # Se o byte atual == 0, pegue a imagem_0
			j LOOP_TILEMAP_ALGARISMO	       # Printa a matriz do byte atual
        CASO_ALGARISMO_1:
            li t3, 1		                   # Pegue o valor 0
			bne s2, t3, CASO_ALGARISMO_2	   # Compare com o valor no byte atual do Tilemap
			la t5, NUMERO_1		               # Se o byte atual == 0, pegue a imagem_0
			j LOOP_TILEMAP_ALGARISMO	       # Printa a matriz do byte atual
        CASO_ALGARISMO_2:
            li t3, 2		                   # Pegue o valor 0
			bne s2, t3, CASO_ALGARISMO_3	   # Compare com o valor no byte atual do Tilemap
			la t5, NUMERO_2		               # Se o byte atual == 0, pegue a imagem_0
			j LOOP_TILEMAP_ALGARISMO	       # Printa a matriz do byte atual
        CASO_ALGARISMO_3:
            li t3, 3		                   # Pegue o valor 0
			bne s2, t3, CASO_ALGARISMO_4	   # Compare com o valor no byte atual do Tilemap
			la t5, NUMERO_3		               # Se o byte atual == 0, pegue a imagem_0
			j LOOP_TILEMAP_ALGARISMO	       # Printa a matriz do byte atual
        CASO_ALGARISMO_4:
            li t3, 4		                   # Pegue o valor 0
			bne s2, t3, CASO_ALGARISMO_5	   # Compare com o valor no byte atual do Tilemap
			la t5, NUMERO_4		               # Se o byte atual == 0, pegue a imagem_0
			j LOOP_TILEMAP_ALGARISMO	       # Printa a matriz do byte atual
        CASO_ALGARISMO_5:
            li t3, 5		                   # Pegue o valor 0
			bne s2, t3, CASO_ALGARISMO_6	   # Compare com o valor no byte atual do Tilemap
			la t5, NUMERO_5		               # Se o byte atual == 0, pegue a imagem_0
			j LOOP_TILEMAP_ALGARISMO	       # Printa a matriz do byte atual
        CASO_ALGARISMO_6:
            li t3, 6		                   # Pegue o valor 0
			bne s2, t3, CASO_ALGARISMO_7	   # Compare com o valor no byte atual do Tilemap
			la t5, NUMERO_6		               # Se o byte atual == 0, pegue a imagem_0
			j LOOP_TILEMAP_ALGARISMO	       # Printa a matriz do byte atual
        CASO_ALGARISMO_7:
            li t3, 7		                   # Pegue o valor 0
			bne s2, t3, CASO_ALGARISMO_8	   # Compare com o valor no byte atual do Tilemap
			la t5, NUMERO_7		               # Se o byte atual == 0, pegue a imagem_0
			j LOOP_TILEMAP_ALGARISMO	       # Printa a matriz do byte atual
        CASO_ALGARISMO_8:
            li t3, 8		                   # Pegue o valor 0
			bne s2, t3, CASO_ALGARISMO_9	   # Compare com o valor no byte atual do Tilemap
			la t5, NUMERO_8		               # Se o byte atual == 0, pegue a imagem_0
			j LOOP_TILEMAP_ALGARISMO	       # Printa a matriz do byte atual
        CASO_ALGARISMO_9:
			la t5, NUMERO_9		               # Se o byte atual == 0, pegue a imagem_0

		###############################################
		######## RENDERIZA ALGARISMO ##################
		###############################################
		# t0 = posicao do tilemap, t5 = endereco da imagem
		# Loop que percorre todo o Tilemap. Da esquerda para direita, de cima para baixo e byte a byte.
		LOOP_TILEMAP_ALGARISMO:
				li t4, 0xFF000000
				li s4, 0xFF100000
				# As contas abaixo objetivam gerar uma correspondencia direta entre a posicao no Tilemap (t0) e no Frame (Endereco em t4)
			
				# 0xFF00 + 5120 * t0 // 20 : 
				li t2, 20	# Pegue o valor 20: Quantidade de colunas no Tilemap
				div t2, t0, t2	# t2 = t0 // 20	: isto eh quantidade de linhas que ja foram processadas no tilemap
				li t3, 5120	# Pegue o valor de 5120 que eh 16 * 320 que equivale a pular 16 linhas para baixo no frame
				mul t2, t3, t2	# t2 = 5120 * t0 // 20 : isto eh quantidade pixels em linha que devem ser pulados
				add t4, t4, t2	# Acrescente ao endereco inicial do Frame
				add s4, s4, t2	# Acrescente ao endereco inicial do Frame
				
				# [0xFF00 + 5120 * t0 // 20] + 16 * (t0 % 20)
				li t2, 20	# Pegue o valor 20: Quantidade de colunas no Tilemap
				rem t2, t0, t2	# Pegue o resto da divisao de t0 % 20 : Colunas restantes a serem contabilizadas
				li t3, 16	# 16 eh o tamanho de colunas em um matriz
				mul t2, t3, t2	# 16 * (t0 % 20) gera o valor em endereco correspondente a quantidade de matriz passadas na matriz
				add t4, t4, t2	# Acrescente ao endereco calculado ate agora
				add s4, s4, t2	# Acrescente ao endereco calculado ate agora

		# Matriz eh um conjunto de 16x16 pixels
		# O loop abaixo printa o valor da imagem correspondente a matriz byte do tilemap
		PREENCHE_MATRIZ_ALGARISMO:
				# Inicializa linha e ultima linha
				li s0, 0	# Linha inicial = 0
				li s1, 16	# Linha final = 16
		# Loop para printar cada linha da matriz
		LOOP_LINHAS_MATRIZ_ALGARISMO:
			beq s0, s1, LOOP_PRINTA_ALGARISMOS	# Enquanto i < 16, faca o abaixo
				# Inicializa coluna e ultima coluna
				li t2, 0	# Coluna inicial = 0
				li t3, 16	# t3 = numero de colunas
			# Loop para printar cada pixel (coluna) de uma linha da respectiva linha da matriz
			LOOP_COLUNA_ALGARISMO:			
				beq t2,t3,SOMA_LINHA_ALGARISMO	# Enquanto coluna < 16
				#PREENCHE_BYTE
				lb t6,0(t5)		# Pegue o byte de cor da imagem
				sb t6,0(t4)		# Pinte o respectivo pixel no Bitmap Display
				sb t6,0(s4)		# Pinte o respectivo pixel no Bitmap Display
				addi t4,t4,1		# Atualiza Endereco atual do frame em 1 byte
				addi s4,s4,1		# Atualiza Endereco atual do frame em 1 byte
				addi t5,t5,1		# Atualiza Endereco atual da imagem em 1 byte
			
				addi t2,t2,1		# coluna++
				j LOOP_COLUNA_ALGARISMO		# Retorne para a verificacao do Loop das Colunas

		# Etapa de iteracao da linha e de correcao do pixel inicial				
		SOMA_LINHA_ALGARISMO:
			addi s0, s0, 1	# linha ++
			
			# Inicia proxima linha
			addi t4, t4, -16	# Retorne ao primeiro pixel da linha
			addi t4, t4, 320	# Passe para a linha abaixo
			
			addi s4, s4, -16	# Retorne ao primeiro pixel da linha
			addi s4, s4, 320	# Passe para a linha abaixo

			j LOOP_LINHAS_MATRIZ_ALGARISMO	# Retorne para a verificacao do Loop das Linhas Matriz

FIM_PRINTA_ALGARISMOS:
	addi sp, sp, -4
	sw ra, 0(sp)

	li t3, 17
	blt t0, t3, ENCERRA_PRINTA_ALGARISMOS

	la t5, IMAGEM_2
	call LOOP_TILEMAP_OBJETO_DUPLO

	lw ra, 0(sp)
	addi sp, sp, 4

ENCERRA_PRINTA_ALGARISMOS:
    ret


######################################################
######## FUNCAO 2 #####################
######################################################
# t0 = Posicao no Tilemap
# t5 = Endereco Imagem do objeto 
LOOP_TILEMAP_OBJETO_DUPLO:
	lui t4, 0xFF000			# Carrega os 20 bits mais a esquerda de t4 com ENDERECO_INICIAL_FRAME : Nesse caso do Frame 0
	lui s4, 0xFF100

	# As contas abaixo objetivam gerar uma correspondencia direta entre a posicao no Tilemap (t0) e no Frame (Endereco em t4)

	# 0xFF00 + 5120 * t0 // 20 : 
	li t2, 20	# Pegue o valor 20: Quantidade de colunas no Tilemap
	div t2, t0, t2	# t2 = t0 // 20	: isto eh quantidade de linhas que ja foram processadas no tilemap
	li t3, 5120	# Pegue o valor de 5120 que eh 16 * 320 que equivale a pular 16 linhas para baixo no frame
	mul t2, t3, t2	# t2 = 5120 * t0 // 20 : isto eh quantidade pixels em linha que devem ser pulados
	add t4, t4, t2	# Acrescente ao endereco inicial do Frame (pro frame 0)
	add s4, s4, t2  # Acrescente ao endereco inicial do Frame (pro frame 1)
	
	# [0xFF00 + 5120 * t0 // 20] + 16 * (t0 % 20)
	li t2, 20	# Pegue o valor 20: Quantidade de colunas no Tilemap
	rem t2, t0, t2	# Pegue o resto da divisao de t0 % 20 : Colunas restantes a serem contabilizadas
	li t3, 16	# 16 eh o tamanho de colunas em um matriz
	mul t2, t3, t2	# 16 * (t0 % 20) gera o valor em endereco correspondente a quantidade de matriz passadas na matriz
	add t4, t4, t2	# Acrescente ao endereco calculado ate agora (pro frame 0)
	add s4, s4, t2  # Acrescente ao endereco calculado ate agora (pro frame 1)

	# Matriz eh um conjunto de 16x16 pixels
	# O loop abaixo printa o valor da imagem correspondente a matriz byte do tilemap
	PREENCHE_MATRIZ_OBJETO:
			# Inicializa linha e ultima linha
			li s0, 0	# Linha inicial = 0
			li s10, 16	# Linha final = 16
	# Loop para printar cada linha da matriz
	LOOP_LINHAS_MATRIZ_OBJETO:
		beq s0, s10, FIM_OBJETO	# Enquanto i < 16, faca o abaixo
			# Inicializa coluna e ultima coluna
			li t2, 0	# Coluna inicial = 0
			li t3, 16	# t3 = numero de colunas
		# Loop para printar cada pixel (coluna) de uma linha da respectiva linha da matriz
		LOOP_COLUNA_OBJETO:			
			beq t2,t3,SOMA_LINHA_OBJETO	# Enquanto coluna < 16
			#PREENCHE_BYTE
			lb t6,0(t5)		# Pegue o byte de cor da imagem
			sb t6,0(t4)		# Pinte o respectivo pixel no Bitmap Display (pro frame 0)
			sb t6,0(s4)		# Pinte o respectivo pixel no Bitmap Display (pro frame 1)
			addi t4,t4,1		# Atualiza Endereco atual do frame em 1 byte (pro frame 0)
			addi s4,s4,1		# Atualiza Endereco atual do frame em 1 byte (pro frame 1)
			addi t5,t5,1		# Atualiza Endereco atual da imagem em 1 byte
		
			addi t2,t2,1		# coluna++
			j LOOP_COLUNA_OBJETO		# Retorne para a verificacao do Loop das Colunas

	# Etapa de iteracao da linha e de correcao do pixel inicial				
	SOMA_LINHA_OBJETO:
		addi s0, s0, 1	# linha ++
		
		# Inicia proxima linha
		addi t4, t4, -16	# Retorne ao primeiro pixel da linha (pro frame 0)
		addi t4, t4, 320	# Passe para a linha abaixo (pro frame 0)
		addi s4, s4, -16	# Retorne ao primeiro pixel da linha (pro frame 1)
		addi s4, s4, 320	# Passe para a linha abaixo (pro frame 1)
		
		j LOOP_LINHAS_MATRIZ_OBJETO	# Retorne para a verificacao do Loop das Linhas Matriz

# Fim_OBJETO do programa
FIM_OBJETO:
	ret

######################################################
######## FUNCAO 3 #####################
######################################################
# t0 = posicao no tilemap
# t5 = Endereco Imagem do objeto 
RenderizacaoDinamica:
	# Seleciona o Frame em que serah renderizado
	lui t4, 0xFF000			# Carrega os 20 bits mais a esquerda de t4 com ENDERECO_INICIAL_FRAME : Nesse caso do Frame 0
	la s3, FRAME
	lw s3, 0(s3)
	slli s3, s3, 20			# Faca o valor em t0, andar 20 bits para a esquerda : Parte da montagem do endereco inicial
	add t4, t4, s3			# Some o valor deslocado a base 0xFF
	# As contas abaixo objetivam gerar uma correspondencia direta entre a posicao no Tilemap (t0) e no Frame (Endereco em t4)

	# 0xFF00 + 5120 * t0 // 20 : 
	li t2, 20	# Pegue o valor 20: Quantidade de colunas no Tilemap
	div t2, t0, t2	# t2 = t0 // 20	: isto eh quantidade de linhas que ja foram processadas no tilemap
	li t3, 5120	# Pegue o valor de 5120 que eh 16 * 320 que equivale a pular 16 linhas para baixo no frame
	mul t2, t3, t2	# t2 = 5120 * t0 // 20 : isto eh quantidade pixels em linha que devem ser pulados
	add t4, t4, t2	# Acrescente ao endereco inicial do Frame (pro frame 0)
	
	# [0xFF00 + 5120 * t0 // 20] + 16 * (t0 % 20)
	li t2, 20	# Pegue o valor 20: Quantidade de colunas no Tilemap
	rem t2, t0, t2	# Pegue o resto da divisao de t0 % 20 : Colunas restantes a serem contabilizadas
	li t3, 16	# 16 eh o tamanho de colunas em um matriz
	mul t2, t3, t2	# 16 * (t0 % 20) gera o valor em endereco correspondente a quantidade de matriz passadas na matriz
	add t4, t4, t2	# Acrescente ao endereco calculado ate agora (pro frame 0)

	# Matriz eh um conjunto de 16x16 pixels
	# O loop abaixo printa o valor da imagem correspondente a matriz byte do tilemap
	PREENCHE_MATRIZ_DINAMICO:
			# Inicializa linha e ultima linha
			li s0, 0	# Linha inicial = 0
			li s10, 16	# Linha final = 16
	# Loop para printar cada linha da matriz
	LOOP_LINHAS_MATRIZ_DINAMICO:
		beq s0, s10, FimRenderizacaoDinamica	# Enquanto i < 16, faca o abaixo
			# Inicializa coluna e ultima coluna
			li t2, 0	# Coluna inicial = 0
			li t3, 16	# t3 = numero de colunas
		# Loop para printar cada pixel (coluna) de uma linha da respectiva linha da matriz
		LOOP_COLUNA_DINAMICO:			
			beq t2, t3, SOMA_LINHA_DINAMICO	# Enquanto coluna < 16
			#PREENCHE_BYTE
			lb t6, 0(t5)		# Pegue o byte de cor da imagem
			sb t6, 0(t4)		# Pinte o respectivo pixel no Bitmap Display (pro frame 0)
			addi t4, t4, 1		# Atualiza Endereco atual do frame em 1 byte (pro frame 0)
			addi t5, t5, 1		# Atualiza Endereco atual da imagem em 1 byte
		
			addi t2,t2,1		# coluna++
			j LOOP_COLUNA_DINAMICO		# Retorne para a verificacao do Loop das Colunas

	# Etapa de iteracao da linha e de correcao do pixel inicial				
	SOMA_LINHA_DINAMICO:
		addi s0, s0, 1	# linha ++
		
		# Inicia proxima linha
		addi t4, t4, -16	# Retorne ao primeiro pixel da linha (pro frame 0)
		addi t4, t4, 320	# Passe para a linha abaixo (pro frame 0)
		
		j LOOP_LINHAS_MATRIZ_DINAMICO	# Retorne para a verificacao do Loop das Linhas Matriz

# Fim_DINAMICO do programa
FimRenderizacaoDinamica:
	ret

# Nao exige registrador exclusivo
# Passa para a fase 2 ou para o fim do jogo a depender da fase atual
Passafase:
    li s0, 2000
    call Espera

    # Passa para o proximo estagio
	la t0, FASE_ATUAL
	lw t0, 0(t0)
	li t2, 2
	beq t0, t2, FIM_GAME_LOOP_FASE_1
	j PASSA_FASE_2
