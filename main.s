.data
	.include "variaveis.data"	# Arquivo que contem todas as variaveis - mapas, posicoes, etc - usadas no jogo
	DEBUG_MSG: .string "Achei um bloco de valor 2\n"

.text

.include "animacao"
SAI_ANIMACAO:

	.include "CONFIGURA.s"

INICIO_GAME_LOOP_FASE_1:

	# li a7, 4
	# la a0, DEBUG_MSG
	# ecall
	.include "REDUZ_TIMER.s"

	# Verifica se o Power Up de forca jah expirou
		# Pega os conteudos de SCORE_TIMER e de TEMPO_INICIAL_POWER_UP_FORCA
		la t2, SCORE_TIMER		
		lw t2, 0(t2)
		la s2, TEMPO_INICIAL_POWER_UP_FORCA
		lw s2, 0(s2)

		# Verifica se passou 6 segundos desde que o PowerUp forca foi pego
		addi s2, s2, -6
		blt s2, t2, CONDICAO_DE_VITORIAS

		# Reseta PowerUp Forca
		la t1, BOOLEANO_FORCA		
		li t2, 0	
    	sw t2, 0(t1)				# Pegue o valor do Power Up

		la s7, ULTIMA_TECLA_PRESSIONADA
		lw s7, 0(s7)
		la t5, IMAGEM_JOGADOR
		# Atualiza SPRITE para o Sprite Normal
		# Switch letras #
		# Caso cima
		li t2, 'w'
		bne s7, t2, CASO_ESQUERDA
			la s6, IMAGEM_JOGADOR_cima
			sw s6, 0(t5)
			j CONDICAO_DE_VITORIAS

		CASO_ESQUERDA:
		li t2, 'a'
		bne s7, t2, CASO_BAIXO
			la s6, IMAGEM_JOGADOR_esquerda
			sw s6, 0(t5)
			j CONDICAO_DE_VITORIAS

		CASO_BAIXO:
		li t2, 's'
		bne s7, t2, CASO_DIREITA
			la s6, IMAGEM_JOGADOR_baixo
			sw s6, 0(t5)
			j CONDICAO_DE_VITORIAS

		CASO_DIREITA:
			la s6, IMAGEM_JOGADOR_direita
			sw s6, 0(t5)


	# Confere se todos os pontos foram coletados (Condicao de Vitoria 1)
	CONDICAO_DE_VITORIAS:

	la t0, MAXIMO_PONTOS
	lw t0, 0(t0)
	la t1, PONTOS
	lw t1, 0(t1)
	bne t0, t1, CONFERE_INIMIGOS_MORTOS
	call Passafase

	# Confere se todos os inimigos estao mortos (Condicao de vitoria 2)
	CONFERE_INIMIGOS_MORTOS:
	li s6, 0
	la s5, POSICAO_INIMIGOS
	la s8, QUANTIDADE_DE_INIMIGOS
	lb s8, 0(s8)
	LOOP_CONFERE_INIMIGOS_MORTOS:
		beq s6, s8, FIM_CONFERE_INIMIGOS_MORTOS
			lw t3, 0(s5)	# Pegue posicao do inimigo i

			# Se houve inimigo vivo ignore
			bnez t3, RENDERIZACOES

			# Itere os contadores
			addi s7, s7, 1	# Contabiliza inimigos mortos
			addi s6, s6, 1	# Itera contador
			addi s5, s5, 4	# Itera Vetor Posicao inimigos
			j LOOP_CONFERE_INIMIGOS_MORTOS

	FIM_CONFERE_INIMIGOS_MORTOS:
	bne s6, s8, RENDERIZACOES
	call Passafase

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

		# Ignora inimigos mortos
		beqz t0, ITERA_LOOP_RENDERIZA_INIMIGOS

		call RenderizacaoDinamica

		ITERA_LOOP_RENDERIZA_INIMIGOS:
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

	.include "victory"
	j SAI_GAME_OVER
	

# Tela de morte ou derrota
	#.include "game_over"
SAI_GAME_OVER:

	li a7, 10
	ecall

.include "FUNCOES.s"
