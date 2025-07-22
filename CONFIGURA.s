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
	li t1, 143
    sw t1, 0(t0)

	# Define que haverao 2 inimigos na fase 2
    la t0, QUANTIDADE_DE_INIMIGOS
	li t1, 1
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
	# Define posicao inicial do jogador
	la t0, POSICAO_JOGADOR
	li t1, 41
	sw t1, 0(t0)
	
	# Define imagem inicial do jogador
	la t1, IMAGEM_JOGADOR_baixo
	la t5, IMAGEM_JOGADOR
	sw t1, 0(t5)

	# Inicializa Booleano do Power Up de forca
	la t1, BOOLEANO_FORCA
	li t5, 0
	sw t5, 0(t1)

	# Inicializa TEMPO_INICIAL_POWER_UP_FORCA
	la s2, TEMPO_INICIAL_POWER_UP_FORCA
	li t0, 200
	sw t0, 0(s2)

	# Inicializa Booleano do Power Up de chute
	la t1, BOOLEANO_CHUTE
	li t5, 0
	sb t5, 0(t1)

	# Inicializa TEMPO_INICIAL_POWER_UP_FORCA
	la s2, TEMPO_INICIAL_POWER_UP_CHUTE
	li t0, 200
	sw t0, 0(s2)

	# Inicializa Offsets da bomba
	la t0, OFFSET_BOMBA
	li t1, 0
	sb t1, 0(t0)	# Offset do primeiro inimigo

################################################
###### Inicializa inimigos ##############
################################################
	# Inicializa Posicao da Bomba
	la t0, POSICAO_BOMBA
	li t1, 0
	sw t1, 0(t0)

	la t0, TEMPO_INICIAL_BOMBA
	li t1, 200
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

	la t1, IMAGEM_FANTASMA_CIMA
	sw t1, 8(t5)	# Imagem do segundo inimigo

	la t1, IMAGEM_FANTASMA_CIMA
	sw t1, 12(t5)	# Imagem do segundo inimigo

	j INICIALIZACOES

CONFIGURA_INIMIGOS_FASE_2:
	# Inicializa Posicao dos inimigo na fase 2

	# Posicao inimigo 1 Fase 2
	la t0, POSICAO_INIMIGOS
	li t1, 42		
	sw t1, 0(t0)	# Posicao do primeiro inimigo

	# Inicializa contador de passos
	la t0, POSICAO_CAMINHO
	li t1, 0
	sb t1, 0(t0)

	# Inicializa Imagens dos inimigos
	la t5, IMAGEM_INIMIGOS
	la t1, IMAGEM_PAC_MAN_DIREITA
	sw t1, 0(t5)	# Imagem do primeiro inimigo

	# Inicializa Offsets dos inimigos
	la t0, OFFSET_INIMIGOS
	li t1, 1
	sb t1, 0(t0)	# Offset do primeiro inimigo

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

	# Inicializa TEMPO_MOVIMENTO_BOMBA
	la s2, TEMPO_MOVIMENTO_BOMBA
	sw a0, 0(s2)	# Inicializa: TEMPO_MOVIMENTO_BOMBA = TEMPO_ATUAL	

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
