################################################
###### Inicializa todos os scores ##############
################################################
	# Inicializa POSICAO_MUSICA
	li t0, 0							# t0 = 0
	la t1, POSICAO_MUSICA				# Pega o endereco de POSICAO_MUSICA
	sw t0, 0(t1)						# POSICAO_MUSICA = 0

	la t0, TAMANHO_MUSICA_FUNDO_FASE_1	# Pegue o enderecao do tamanho da musica que deve ser tocada
	lw t0, 0(t0)						# Pegue o valor do tamanho da musica
	la t1, TAMANHO_MUSICA				# Pegue o endereco da variavel generica de tamanho
	sw t0, 0(t1)						# Variavel generica = Tamanho musica atual

################################################
### Inicializa instrumento (Timbre) e volume ###
################################################
	li a2, 127
	li a3, 127
##############################################################
# Inicializa todos os TEMPO_INICIAL das funcoes periodicas ###
##############################################################
	# Pega tempo atual
	li a7, 30
	ecall

	# Correcoa para que todas funcoes rodem pela primeira vez
	li t0, -6000		# O valor aqui precisa ser ajustado para que todas as funcoes funcionem
	add a0, a0, t0		# "Atrasa" TEMPO_ATUAL

	# Inicializa TEMPO_INICIAL_MUSICA
	la s2, TEMPO_INICIAL_MUSICA
	sw a0, 0(s2)	# Inicializa: TEMPO_INICIA_TESTE = TEMPO_ATUAL	



INICIO_GAME_LOOP_FASE_1:

	#.include "TECLADO_FASE_1.s"

##################################################
### ESPERA(DURACAO_NOTA_ATUAL) PARA TOCA_NOTA ####
##################################################

	# Pega tempo em TEMPO_INICIAL_MUSICA
	la s2, TEMPO_INICIAL_MUSICA	# Pega endereco de TEMPO_ATUAL
	lw s2, 0(s2)				# s2 = conteudo na variavel TEMPO_INICIAL_MUSICA

	# Pega tempo atual
	li a7, 30		# Pega o tempo atual
	ecall			# Chama o sistema operacional e guarda tempo atual em a0

	# Pega duracao da nota atual
	la t2, POSICAO_MUSICA				# Pega o indice em POSICAO_MUSICA (Nota sendo tocada)
	lw t2, 0(t2)						# Pega o valor de POSICAO_MUSICA
	la t4, NOTAS_MUSICA_FUNDO_FASE_1	# Pega endereco inicial do vetor Notas
	add t4, t4, t2						# t4 = Endereco_inicial + Notas : Ou seja endereco nota atual
	lw t2, 4(t4)						# Pega a duracao da nota atual

	# Confere o tempo passado desde que a nota comecou a ser tocada
	sub t3, a0, s2			# t3 = TEMPO_ATUAL - TEMPO_INICIAL_TESTE
	blt t3, t2, PULA_TOCA_PROXIMA_NOTA 	# Se t3 >= duracao da nota em milisegundos -> toque proxima nota

##################################################
### FUNCAO: TOCA_PROXIMA_NOTA() ####
##################################################

	addi t2, t2, 1
	sw 

	# Atualiza TEMPO_INICIAL_MUSICA
	li a7, 30
	ecall
	
	la s2, TEMPO_INICIAL_MUSICA
	sw a0, 0(s2)
	
PULA_TOCA_PROXIMA_NOTA:	