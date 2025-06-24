##################################################################
############# RENDERIZA COMPLETAMENTE O CAMPO ##################
##################################################################
INICIO_JOGADOR:
	la t0, POSICAO_JOGADOR
	lw t0, 0(t0)

	lw t5, IMAGEM_JOGADOR

# Loop que percorre todo o Tilemap. Da esquerda para direita, de cima para baixo e byte a byte.
LOOP_TILEMAP_JOGADOR:
		lui t4, 0xFF000			# Carrega os 20 bits mais a esquerda de t4 com ENDERECO_INICIAL_FRAME : Nesse caso do Frame 0
		li t1, 0xFF200604		# Pega endereco de SELECAO_DE_FRAME_EXIBIDO
		lw t1, 0(t1)			# Pega conteudo de SELECAO_DE_FRAME_EXIBIDO
		slli t1, t1, 20			# Faca o valor em t0, andar 20 bits para a esquerda : Parte da montagem do endereco inicial
		add t4, t4, t1			# Some o valor deslocado a base 0xFF

		# As contas abaixo objetivam gerar uma correspondencia direta entre a posicao no Tilemap (t0) e no Frame (Endereco em t4)
	
		# 0xFF00 + 5120 * t0 // 20 : 
		li t2, 20	# Pegue o valor 20: Quantidade de colunas no Tilemap
		div t2, t0, t2	# t2 = t0 // 20	: isto eh quantidade de linhas que ja foram processadas no tilemap
		li t3, 5120	# Pegue o valor de 5120 que eh 16 * 320 que equivale a pular 16 linhas para baixo no frame
		mul t2, t3, t2	# t2 = 5120 * t0 // 20 : isto eh quantidade pixels em linha que devem ser pulados
		add t4, t4, t2	# Acrescente ao endereco inicial do Frame
		
		# [0xFF00 + 5120 * t0 // 20] + 16 * (t0 % 20)
		li t2, 20	# Pegue o valor 20: Quantidade de colunas no Tilemap
		rem t2, t0, t2	# Pegue o resto da divisao de t0 % 20 : Colunas restantes a serem contabilizadas
		li t3, 16	# 16 eh o tamanho de colunas em um matriz
		mul t2, t3, t2	# 16 * (t0 % 20) gera o valor em endereco correspondente a quantidade de matriz passadas na matriz
		add t4, t4, t2	# Acrescente ao endereco calculado ate agora

# Matriz eh um conjunto de 16x16 pixels
# O loop abaixo printa o valor da imagem correspondente a matriz byte do tilemap
PREENCHE_MATRIZ_JOGADOR:
		# Inicializa linha e ultima linha
		li s0, 0	# Linha inicial = 0
		li s1, 16	# Linha final = 16
# Loop para printar cada linha da matriz
LOOP_LINHAS_MATRIZ_JOGADOR:
	beq s0, s1, FIM_JOGADOR	# Enquanto i < 16, faca o abaixo
		# Inicializa coluna e ultima coluna
		li t2, 0	# Coluna inicial = 0
		li t3, 16	# t3 = numero de colunas
	# Loop para printar cada pixel (coluna) de uma linha da respectiva linha da matriz
	LOOP_COLUNA_JOGADOR:			
		beq t2,t3,SOMA_LINHA_JOGADOR	# Enquanto coluna < 16
		#PREENCHE_BYTE
		lb t6,0(t5)		# Pegue o byte de cor da imagem
		sb t6,0(t4)		# Pinte o respectivo pixel no Bitmap Display
		addi t4,t4,1		# Atualiza Endereco atual do frame em 1 byte
		addi t5,t5,1		# Atualiza Endereco atual da imagem em 1 byte
	
		addi t2,t2,1		# coluna++
		j LOOP_COLUNA_JOGADOR		# Retorne para a verificacao do Loop das Colunas

# Etapa de iteracao da linha e de correcao do pixel inicial				
SOMA_LINHA_JOGADOR:
	addi s0, s0, 1	# linha ++
	
	# Inicia proxima linha
	addi t4, t4, -16	# Retorne ao primeiro pixel da linha
	addi t4, t4, 320	# Passe para a linha abaixo
	
	j LOOP_LINHAS_MATRIZ_JOGADOR	# Retorne para a verificacao do Loop das Linhas Matriz

# Fim_JOGADOR do programa
FIM_JOGADOR:
