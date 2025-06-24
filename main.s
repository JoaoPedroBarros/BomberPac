.data
	.include "variaveis.data"	# Arquivo que contem todas as variaveis - mapas, posicoes, etc - usadas no jogo
	DEBUG_MSG: .string "Achei um bloco de valor 2\n"

.text
CONFIGURA_FASE_1:
##########################################################
# Renderiza os frames estaticamente (por completo) #######
##########################################################
	.include "RENDERIZA_FRAME_0_FASE_1.s"
	.include "RENDERIZA_FRAME_1_FASE_1.s"
	#j FIM_GAME_LOOP_FASE_1

################################################
###### Inicializa Frame a ser renderizado ######
################################################
	li t0, 0xFF200604	# Pega endereco de SELECAO_DE_FRAME_EXIBIDO
	li t1, 0			# Pega o valor 0
	sw t1, 0(t0)		# O primeiro FRAME a ser mostrado serah o FRAME 0

################################################
###### Inicializa posicao Jogador ##############
################################################
	la t0, POSICAO_JOGADOR
	li t1, 41
	sw t1, 0(t0)
	
	la t1, IMAGEM_JOGADOR_baixo
	la t5, IMAGEM_JOGADOR
	sw t1, 0(t5)

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

#############################################################
# Inicializa as variaveis de usadas na MUSICA ###
#############################################################

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

	# ####################################
	# # RENDERIZAÇOES DINAMICAS #
	# ####################################
	.include "RENDERIZA_CAMPO.s"
	.include "RENDERIZA_JOGADOR.s"

	# Troca/Inverte Frames
	li t0, 0xFF200604	# Pega endereco de SELECAO_DE_FRAME_EXIBIDO
	lw t1, 0(t0)		# Pega o valor 0
	xori t1, t1, 1		# Se Frame atual == 0, alterna para o frame 1 e vice-versa
	sw t1, 0(t0)		# Atualiza o valor de SELECAO_DE_FRAME_EXIBIDO
	
	.include "TECLADO_FASE_1.s"

	# ############################
	# # FUNCAO ATUALIZA_TILEMAP
	# ############################
	# A posicao do personagem eh salva como parte do Tilemap

	.include "ATUALIZA_TILEMAP.s"

	.include "TOCA_MUSICA.s"

	j INICIO_GAME_LOOP_FASE_1

FIM_GAME_LOOP_FASE_1:
	li a7, 10
	ecall

#CONFIGURA_FASE_2:
#INICIO_GAME_LOOP_FASE_2:

#FIM_GAME_LOOP_FASE_2:
