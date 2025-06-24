##################################################################
############# RENDERIZA COMPLETAMENTE O FRAME 0 ##################
##################################################################
INICIO_FRAME_0_FASE_1:
	la s2, TILEMAP_MUTAVEL	# Pegue o endereco do Tilemap
	addi s2, s2, -1		# Essa correcao permite que o LOOP_TILEMAP_FRAME_0_FASE_1 sempre funcione com iterando o endereco do byte do tilemap
	li t0, 0		# Primeira matriz do tilemap
	li t1, 299		# Ultima matriz do tilemap
# Loop que percorre todo o Tilemap. Da esquerda para direita, de cima para baixo e byte a byte.
LOOP_TILEMAP_FRAME_0_FASE_1:
	bgt t0, t1, FIM_FRAME_0_FASE_1		# Enquanto t0 < ultima matriz do tilemap, faca o abaixo
		lui t4, 0xFF000	# Carrega os 20 bits mais a esquerda de t4 com ENDERECO_INICIAL_FRAME : Nesse caso do Frame 0
	
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

		addi s2, s2, 1	# Itere o endereco do byte no tilemap
		lb t5, 0(s2)	# Valor da matriz no Tilemap

CASO_1_FRAME_0_FASE_1:
		li t2, 1		# Pegue o valor 0										
		bne t5, t2, ITERA_LOOP_TILEMAP_FRAME_0_FASE_1	# Compare com o valor no byte atual do Tilemap.
		la t5, IMAGEM_1		# Se o byte atual == 1, pegue a imagem_1
		j PREENCHE_MATRIZ_FRAME_0_FASE_1	# Printa a matriz do byte atual

# Os casos abaixos pegam a imagem que deve ser printada
# CASO_0_FRAME_0_FASE_1:
# 		li t2, 0		# Pegue o valor 0
# 		bne t5, t2, CASO_1_FRAME_0_FASE_1	# Compare com o valor no byte atual do Tilemap
# 		la t5, IMAGEM_0		# Se o byte atual == 0, pegue a imagem_0
# 		j PREENCHE_MATRIZ_FRAME_0_FASE_1	# Printa a matriz do byte atual
# CASO_1_FRAME_0_FASE_1:
# 		li t2, 1		# Pegue o valor 0										
# 		bne t5, t2, CASO_2_FRAME_0_FASE_1	# Compare com o valor no byte atual do Tilemap
# 		la t5, IMAGEM_1		# Se o byte atual == 1, pegue a imagem_1
# 		j PREENCHE_MATRIZ_FRAME_0_FASE_1	# Printa a matriz do byte atual
# CASO_2_FRAME_0_FASE_1:
# 		li t2, 2		# Pegue o valor 0
# 		bne t5, t2, CASO_3_FRAME_0_FASE_1	# Compare com o valor no byte atual do Tilemap
# 		la t5, IMAGEM_2		# Se o byte atual == 2, pegue a imagem_2
# 		j PREENCHE_MATRIZ_FRAME_0_FASE_1	# Printa a matriz do byte atual							
# CASO_3_FRAME_0_FASE_1:
# 		li t2, 3			# Pegue o valor 0
# 		# O ultimo caso possui uma comparacao oposta dos demais (!= ao inves de ==).
# 		bne t5, t2, ITERA_LOOP_TILEMAP_FRAME_0_FASE_1	# Compare com o valor no byte atual do Tilemap.
# 		la t5, IMAGEM_3			# Se o byte atual == 3, pegue a imagem_3

# Matriz eh um conjunto de 16x16 pixels
# O loop abaixo printa o valor da imagem correspondente a matriz byte do tilemap
PREENCHE_MATRIZ_FRAME_0_FASE_1:
		# Inicializa linha e ultima linha
		li s0, 0	# Linha inicial = 0
		li s1, 16	# Linha final = 16
# Loop para printar cada linha da matriz
LOOP_LINHAS_MATRIZ_FRAME_0_FASE_1:
	beq s0, s1, ITERA_LOOP_TILEMAP_FRAME_0_FASE_1	# Enquanto i < 16, faca o abaixo
		# Inicializa coluna e ultima coluna
		li t2, 0	# Coluna inicial = 0
		li t3, 16	# t3 = numero de colunas
	# Loop para printar cada pixel (coluna) de uma linha da respectiva linha da matriz
	LOOP_COLUNA_FRAME_0_FASE_1:			
		beq t2,t3,SOMA_LINHA_FRAME_0_FASE_1	# Enquanto coluna < 16
		#PREENCHE_BYTE
		lb t6,0(t5)		# Pegue o byte de cor da imagem
		sb t6,0(t4)		# Pinte o respectivo pixel no Bitmap Display
		addi t4,t4,1		# Atualiza Endereco atual do frame em 1 byte
		addi t5,t5,1		# Atualiza Endereco atual da imagem em 1 byte
	
		addi t2,t2,1		# coluna++
		j LOOP_COLUNA_FRAME_0_FASE_1		# Retorne para a verificacao do Loop das Colunas

# Etapa de iteracao da linha e de correcao do pixel inicial				
SOMA_LINHA_FRAME_0_FASE_1:
	addi s0, s0, 1	# linha ++
	
	# Inicia proxima linha
	addi t4, t4, -16	# Retorne ao primeiro pixel da linha
	addi t4, t4, 320	# Passe para a linha abaixo
	
	j LOOP_LINHAS_MATRIZ_FRAME_0_FASE_1	# Retorne para a verificacao do Loop das Linhas Matriz

# Etapa de iteracao do byte no Tilemap		
ITERA_LOOP_TILEMAP_FRAME_0_FASE_1:
		addi t0, t0, 1	# t0++
		j LOOP_TILEMAP_FRAME_0_FASE_1 # Retorne para a verificacao do Loop que percorre o Tilemap
# Fim_FRAME_0_FASE_1 do programa
FIM_FRAME_0_FASE_1: