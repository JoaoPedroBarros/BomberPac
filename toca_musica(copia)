	la t0, INDICE_NOTA					# t0 = &INDICE_NOTA
	lw t1, 0(t0)						# t1 = conteudo INDICE_NOTA

	# Garantia de primeiro funcionamento no loop 0
	beqz t1, TOCA_NOTA_FASE_1

	# Pega tempo atual
	li a7, 30           # Chama a funcao TIME()
	ecall               # Chama o Sistema operacional

	# Pega tempo em TEMPO_INICIAL_MUSICA
	la s2, TEMPO_INICIAL_MUSICA		# Pega endereco de TEMPO_INICIAL_MUSICA
	lw s2, 0(s2)                    # Pega o conteudo de TEMPO_INICIAL_MUSICA

	# Condicao para tocar nota
	bge a0, s2, TOCA_NOTA_FASE_1
	j FIM_TOCA_NOTA_FASE_1

TOCA_NOTA_FASE_1:
	# Conversao de indice de nota para Endereco da nota
	# Calcula quantos bytes devem ser pulados
	li t0, 8			# 8 bytes corresponde a uma Nota
	mul t0, t0, t1		# t1 * 8 == numero de bytes a serem pulados ateh a nota atual

	# Adiciona os bytes pulados ao endereco inicial da musica
	la t4, NOTAS_MUSICA_FUNDO_FASE_1	# Pega endereco de NOTAS_MUSICA_FUNDO_FASE_1
	add t4, t4, t0						# t4 = Endereco da nota atual

	# Atualiza valores no "reprodutor de som"
	#addi t4, t4, 8		# t4 = Endereco proxima nota
	lw a0, 0(t4)		# a0 = valor da proxima nota
	lw a1, 4(t4)		# a1 = duracao da proxima nota

	# Toca nota
	li a7, 31			# Configura sistema para tocar a nota midi escolhida acima
	ecall				# Chama o sistema operacional

	# Atualiza Nota
	lw t3, 4(t4)		# Pega duracao da musica
	# Pega Tempo atual
	li a7, 30   # Chama a funcao TIME()
	ecall       # Chama o Sistema operacional

	add t3, a0, t3	# Tempo_proxima_nota = Tempo_atual + Duracao_nota_atual

	# Pega tempo em TEMPO_INICIAL_MUSICA
	la s2, TEMPO_INICIAL_MUSICA		# Pega endereco de TEMPO_INICIAL_MUSICA
	sw t3, 0(s2)                    # TEMPO_INICIAL_MUSICA = Tempo_proxima_nota

	# Permite loop musical
	addi t1, t1, 1						# t1++	: Passa para a proxima nota
	la t2, TAMANHO_MUSICA				# Pega endereco do TAMANHO_MUSICA
	lw t2, 0(t2)						# Pega conteudo do TAMANHO_MUSICA
	rem t1, t1, t2						# t1 = t1 % t2 : INDICE_NOTA = INDICE_NOTA % TAMANHO_MUSICA : Gera o loop musical
	la t0, INDICE_NOTA					# t0 = &INDICE_NOTA
	sw t1, 0(t0)						# INDICE_NOTA = t1


FIM_TOCA_NOTA_FASE_1: