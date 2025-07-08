.data
	.include "variaveis.data"	# Arquivo que contem todas as variaveis - mapas, posicoes, etc - usadas no jogo
	DEBUG_MSG: .string "Achei um bloco de valor 2\n"

.text

.include "animacao"
SAI_ANIMACAO:

################################################
###### Controle de Fases ######
################################################
	# Define tilemap atual como tilemap da fase 1
	la t0, FASE_1
	la t1, TILEMAP_MUTAVEL
	sw t0, 0(t1)

	# Define fase atual como a fase 1
    la t0, FASE_ATUAL
	li t1, 1
    sw t1, 0(t0)

	# Define que haverao 4 inimigos na fase 1
    la t0, QUANTIDADE_DE_INIMIGOS
	li t1, 4
    sb t1, 0(t0)

	# Define condicao de vitoria por coleta de pontos na fase 1
    la t0, MAXIMO_PONTOS
	li t1, 166
    sw t1, 0(t0)

	j CONFIGURA_FASE_1

PASSA_FASE_2:
	# Apaga o HUD #
	li t0, 0
	li s6, 19
	LOOP_ESVAZIA_HUD:
		beq t0, s6, FIM_ESVAZIA_HUD
			la t5, IMAGEM_2
			call LOOP_TILEMAP_OBJETO_DUPLO
			addi t0, t0, 1
			j LOOP_ESVAZIA_HUD
	FIM_ESVAZIA_HUD:

	# Define tilemap atual como tilemap da fase 2
	la t0, FASE_2
	la t1, TILEMAP_MUTAVEL
	sw t0, 0(t1)

	# Define fase atual como a fase 2
	la t0, FASE_ATUAL
	li t1, 2
    sw t1, 0(t0)

	# Define condicao de vitoria por coleta de pontos na fase 2
    la t0, MAXIMO_PONTOS
	li t1, 138
    sw t1, 0(t0)

	# Define que haverao 2 inimigos na fase 2
    la t0, QUANTIDADE_DE_INIMIGOS
	li t1, 2
    sb t1, 0(t0)

CONFIGURA_FASE_1:
##########################################################
# Renderiza os frames estaticamente (por completo) #######
##########################################################
	.include "RENDERIZA_FRAME_0_FASE_1.s"
	.include "RENDERIZA_FRAME_1_FASE_1.s"
	.include "RENDERIZA_HUD.s"

################################################
###### Inicializa Frame a ser renderizado ######
################################################
	li t0, 0xFF200604	# Pega endereco de SELECAO_DE_FRAME_EXIBIDO
	li t1, 0			# Pega o valor 0
	sw t1, 0(t0)		# O primeiro FRAME a ser mostrado serah o FRAME 0

	la t0, FRAME		# Pega endereco de Frame (a ser renderizado)
	li t1, 1			# Pega o valor 0
	sw t1, 0(t0)		# O primeiro FRAME a ser mostrado serah o FRAME 0

	la t5, ULTIMA_TECLA_PRESSIONADA
	li t0, 's'
    sw t0, 0(t5)

################################################
###### Inicializa posicao Jogador ##############
################################################
	la t0, POSICAO_JOGADOR
	li t1, 41
	sw t1, 0(t0)
	
	la t1, IMAGEM_JOGADOR_baixo
	la t5, IMAGEM_JOGADOR
	sw t1, 0(t5)

	la t1, BOOLEANO_FORCA
	li t5, 0
	sw t5, 0(t1)

	# # Inicializa TEMPO_INICIAL_POWER_UP_FORCA
	# la s2, TEMPO_INICIAL_POWER_UP_FORCA
	# li t0, -1
	# sw t0, 0(s2)	# Inicializa: TEMPO_INICIAL_MUSICA = TEMPO_ATUAL

################################################
###### Inicializa inimigos ##############
################################################
	# Inicializa Posicao da Bomba
	la t0, POSICAO_BOMBA
	li t1, 0
	sw t1, 0(t0)

	# Define fase atual como a fase 2
	la t0, FASE_ATUAL
    lw t0, 0(t0)

	li t2, 2
	beq t0, t2, CONFIGURA_INIMIGOS_FASE_2

	# Inicializa Posicoes dos inimigos
	la t0, POSICAO_INIMIGOS
	li t1, 98
	sw t1, 0(t0)	# Posicao do primeiro inimigo
	
	li t1, 278
	sw t1, 4(t0)	# Posicao do segundo inimigo

	li t1, 270
	sw t1, 8(t0)	# Posicao do segundo inimigo

	li t1, 269
	sw t1, 12(t0)	# Posicao do segundo inimigo
	
	# Inicializa Offsets dos inimigos
	la t0, OFFSET_INIMIGOS
	li t1, -1
	sb t1, 0(t0)	# Offset do primeiro inimigo
	
	li t1, -1
	sb t1, 1(t0)	# Offset do segundo inimigo

	la t0, OFFSET_INIMIGOS
	li t1, -20
	sb t1, 2(t0)	# Offset do primeiro inimigo
	
	li t1, -20
	sb t1, 3(t0)	# Offset do segundo inimigo

	# Inicializa Imagens dos inimigos
	la t5, IMAGEM_INIMIGOS
	la t1, IMAGEM_FANTASMA_ESQUERDA
	sw t1, 0(t5)	# Imagem do primeiro inimigo

	la t1, IMAGEM_FANTASMA_ESQUERDA
	sw t1, 4(t5)	# Imagem do segundo inimigo

	la t1, IMAGEM_FANTASMA_ESQUERDA
	sw t1, 8(t5)	# Imagem do segundo inimigo

	la t1, IMAGEM_FANTASMA_ESQUERDA
	sw t1, 12(t5)	# Imagem do segundo inimigo

	j INICIALIZACOES

CONFIGURA_INIMIGOS_FASE_2:
	# Inicializa Posicoes dos inimigos
	la t0, POSICAO_INIMIGOS
	li t1, 278
	sw t1, 0(t0)	# Posicao do primeiro inimigo
	
	li t1, 258
	sw t1, 4(t0)	# Posicao do segundo inimigo

INICIALIZACOES:
################################################
###### Inicializa todos os scores ##############
################################################
	.include "INICIALIZA_SCORES.s"
##############################################################
# Inicializa todos os TEMPO_INICIAL das funcoes periodicas ###
##############################################################
	# Pega tempo atual
	li a7, 30
	ecall

	# Correcao para que todas funcoes rodem pela primeira vez
	li t0, -6000		# O valor aqui precisa ser ajustado para que todas as funcoes funcionem
	add a0, a0, t0		# "Atrasa" TEMPO_ATUAL
											
	# Inicializa TEMPO_INICIAL_SCORE_TIMER
	la s2, TEMPO_INICIAL_SCORE_TIMER
	sw a0, 0(s2)	# Inicializa: TEMPO_INICIAL_SCORE_TIMER = TEMPO_ATUAL			

	# Inicializa TEMPO_INICIAL_MUSICA
	la s2, TEMPO_INICIAL_MUSICA
	li t0, 0
	sw t0, 0(s2)	# Inicializa: TEMPO_INICIAL_MUSICA = TEMPO_ATUAL

	# Inicializa TEMPO_INICIAL_INIMIGOS
	la t0, TEMPO_INICIAL_INIMIGOS
	li s0, 0
	la s1, QUANTIDADE_DE_INIMIGOS
	lb s1, 0(s1)
	LOOP_TEMPO_INICIAL_INIMIGOS:
		beq s0, s1, CONFIGURA_MUSICA
			sw a0, 0(t0)	# TEMPO_INICIAL_INIMIGOS[s0] = a0
			addi s0, s0, 1	# Itera contador
			addi t0, t0, 4	# Itera vetor TEMPO_INICIAL_INIMIGOS
		j LOOP_TEMPO_INICIAL_INIMIGOS

#############################################################
# Inicializa as variaveis de usadas na MUSICA ###
#############################################################
CONFIGURA_MUSICA:
	# Configura instrumento
	li a2, 42	# Define que o timbre do instrumento : Nesse caso, um instrumento de cordas qualquer
	li a3, 80	# Define o volume da nota : Nesse caso 80 decibeis

	# Inicializa ponteiro ("agulha") da musica
	li t0, 0			# t0 = 0
	la t1, INDICE_NOTA	# t1 = &INDICE_NOTA
	sw t0, 0(t1)		# INDICE_NOTA = 0 : Comecamos a musica na nota 0

	# Inicializa TAMANHO_MUSICA : variavel auxiliar que guarda o numero de notas da musica. Serve para permitir loop de musica
	la t0, TAMANHO_MUSICA_FUNDO_FASE_1	# Pega endereco de TAMANHO_MUSICA_FUNDO_FASE_1
	lw t0, 0(t0)						# Pega conteudo de TAMANHO_MUSICA_FUNDO_FASE_1
	la t1, TAMANHO_MUSICA				# Pega endereco de TAMANHO_MUSICA
	sw t0, 0(t1)						# TAMANHO_MUSICA = TAMANHO_MUSICA_FUNDO_FASE_1

INICIO_GAME_LOOP_FASE_1:

	# li a7, 4
	# la a0, DEBUG_MSG
	# ecall
	.include "REDUZ_TIMER.s"

	# Confere se todos os pontos foram coletados
	la t0, MAXIMO_PONTOS
	lw t0, 0(t0)
	la t1, PONTOS
	lw t1, 0(t1)
	bne t0, t1, RENDERIZACOES

	la t0, FASE_ATUAL
	lw t0, 0(t0)
	li t2, 2
	beq t0, t2, FIM_GAME_LOOP_FASE_1
	j PASSA_FASE_2

	RENDERIZACOES:
	# ####################################
	# # RENDERIZAÇOES DINAMICAS #
	# ####################################

	.include "RENDERIZA_CAMPO.s"
	## Renderiza Inimigos
	la s5 POSICAO_INIMIGOS
	la s7 IMAGEM_INIMIGOS
	li s6, 0
	la s8, QUANTIDADE_DE_INIMIGOS
	lb s8, 0(s8)
	LOOP_RENDERIZA_INIMIGOS:
		beq s6, s8, FIM_LOOP_RENDERIZA_INIMIGOS
		lw t5, 0(s7) 
		lw t0, 0(s5)
		call RenderizacaoDinamica
		addi s5, s5, 4
		addi s7, s7, 4
		addi s6, s6, 1
		j LOOP_RENDERIZA_INIMIGOS
	FIM_LOOP_RENDERIZA_INIMIGOS:

	## Renderiza Jogador
	la t0, POSICAO_JOGADOR
	lw t0, 0(t0)
	lw t5, IMAGEM_JOGADOR
	call RenderizacaoDinamica

	# Troca/Inverte Frames
	li t0, 0xFF200604	# Pega endereco de SELECAO_DE_FRAME_EXIBIDO
	lw t1, 0(t0)		# Pega o valor 0
	xori t1, t1, 1		# Se Frame atual == 0, alterna para o frame 1 e vice-versa
	sw t1, 0(t0)		# Atualiza o valor de SELECAO_DE_FRAME_EXIBIDO
	xori t1, t1, 1
	la t0, FRAME
	sw t1, 0(t0)

	.include "auxiliar.s"

	.include "TECLADO_FASE_1.s"

	# ############################
	# # FUNCAO ATUALIZA_TILEMAP
	# ############################
	# A posicao do personagem eh salva como parte do Tilemap

	.include "ATUALIZA_TILEMAP.s"

	#####################################################################################
	######## Incrementar musica para receber vetor instrumento e volume #####################
	#################################################################################
	#.include "TOCA_MUSICA.s"

	j INICIO_GAME_LOOP_FASE_1

FIM_GAME_LOOP_FASE_1:

.include "game_over"
SAI_GAME_OVER:

	li a7, 10
	ecall

######################################################
######## FUTURO BLOCO DE FUNCOES #####################
######################################################
# O intuito dessas funcoes eh diminuir o codigo para evitar problemas de salto (j, call)

# s0 = Tempo de espera em milisegundos (Valor deve ser nao negativo)
Espera:
	li a7, 30
	ecall
	add s0, a0, t0
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
    ret

######################################################
######## FUNCAO 2 #####################
######################################################
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
			li s1, 16	# Linha final = 16
	# Loop para printar cada linha da matriz
	LOOP_LINHAS_MATRIZ_OBJETO:
		beq s0, s1, FIM_OBJETO	# Enquanto i < 16, faca o abaixo
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
			li s1, 16	# Linha final = 16
	# Loop para printar cada linha da matriz
	LOOP_LINHAS_MATRIZ_DINAMICO:
		beq s0, s1, FimRenderizacaoDinamica	# Enquanto i < 16, faca o abaixo
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
