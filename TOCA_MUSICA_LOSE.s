	la t0, INDICE_NOTA_LOSE					# t0 = &INDICE_NOTA
	lw t1, 0(t0)						# t1 = conteudo INDICE_NOTA

	# Garantia de primeiro funcionamento no loop 0
	beqz t1, TOCA_NOTA_LOSE

LOOP_MUSICA_LOSE:
	li t2, 20
	beq t1, t2, FIM_TOCA_NOTA_LOSE

	# Pega tempo atual
	li a7, 30           # Chama a funcao TIME()
	ecall               # Chama o Sistema operacional

	# Pega tempo em TEMPO_INICIAL_MUSICA
	la s4, TEMPO_INICIAL_MUSICA_LOSE		# Pega endereco de TEMPO_INICIAL_MUSICA
	lw s4, 0(s4)                    # Pega o conteudo de TEMPO_INICIAL_MUSICA

	# Condicao para tocar nota
	bge a0, s4, TOCA_NOTA_LOSE
	j LOOP_MUSICA_LOSE

TOCA_NOTA_LOSE:
	# Conversao de indice de nota para Endereco da nota
	# Calcula quantos bytes devem ser pulados
	li t0, 16			# 8 bytes corresponde a uma Nota
	mul t0, t0, t1		# t1 * 8 == numero de bytes a serem pulados ateh a nota atual

	# Adiciona os bytes pulados ao endereco inicial da musica
	la t4, NOTAS_MUSICA_LOSE	# Pega endereco de NOTAS_MUSICA_FUNDO_FASE_1
	add t4, t4, t0						# t4 = Endereco da nota atual

	# Atualiza valores no "reprodutor de som"
	#addi t4, t4, 8		# t4 = Endereco proxima nota
	lw a0, 0(t4)		# a0 = valor da proxima nota
	lw a1, 4(t4)		# a1 = duracao da proxima nota em milissegundos
	lw a2, 8(t4)		# a2 = instrumento da proxima nota
	lw a3, 12(t4)		# a3 = volume da proxima nota em decibeis

	# Toca nota
	bne a3, zero, TOCA_NOTA2
	j ATUALIZA_NOTA_LOSE

	TOCA_NOTA2: 
	li a7, 31			# Configura sistema para tocar a nota midi escolhida acima
	ecall				# Chama o sistema operacional
	j PROXIMO_INDICE_LOSE

	# Atualiza Nota
	ATUALIZA_NOTA_LOSE:
	lw t3, 4(t4)		# Pega duracao da musica
	# Pega Tempo atual
	li a7, 30   # Chama a funcao TIME()
	ecall       # Chama o Sistema operacional

	add t3, a0, t3	# Tempo_proxima_nota = Tempo_atual + Duracao_nota_atual

	# Pega tempo em TEMPO_INICIAL_MUSICA
	la s4, TEMPO_INICIAL_MUSICA_LOSE		# Pega endereco de TEMPO_INICIAL_MUSICA
	sw t3, 0(s4)                    # TEMPO_INICIAL_MUSICA = Tempo_proxima_nota

	# Permite loop musical
	PROXIMO_INDICE_LOSE:
	addi t1, t1, 1						# t1++	: Passa para a proxima Nota
	la t0, INDICE_NOTA_LOSE					# t0 = &INDICE_NOTA
	sw t1, 0(t0)						# INDICE_NOTA = t1

	j LOOP_MUSICA_LOSE


FIM_TOCA_NOTA_LOSE: