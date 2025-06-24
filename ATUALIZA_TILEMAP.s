	la s0, TECLA_LIDA           # Pegue o endereco de TECLA_LIDA
    lw s0, 0(s0)

# Os casos abaixos definem o evento que ocorrerah
CASO_TECLA_w:
    li t2, 119		            # Pegue o valor 'w' na tabela ASCII	
    bne s0, t2, CASO_TECLA_a	# Se a tecla pressionada nao foi 'w'
    
    la s0, POSICAO_JOGADOR		# Pegue endereco POSICAO_ATUAL_JOGADOR
    lw t0, 0(s0)                # Pegue conteudo POSICAO_ATUAL_JOGADOR
    addi t0, t0, -20             # Adicone o offset

    la s1, TILEMAP_MUTAVEL  # Pegue endereco inicial do TILEMAP
    add s1, s1, t0          # Pegue endereco da matriz POSICAO_ATUAL_JOGADOR + OFFSET
    lb s3, 0(s1)            # Pegue conteudo da matriz POSICAO_ATUAL_JOGADOR + OFFSET


    ## EVENTO: COLISAO BLOCOS ##
    li t2, 1                            # Pegue o valor 1
    beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco indestrutivel (Pilastra)
    li t2, 3                            # Pegue o valor 3
    beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)

    li t2, 4
    sb t2, 0(s1)    # Movimenta o JOGADOR

    addi s1, s1, 20	    # Retira offset
    li t2, 0        	# Pegue o valor 0
    sb t2, 0(s1)    	# Apague rastro do Jogador

    sw t0, 0(s0)    # Atualiza POSICAO_JOGADOR
        
    ## atualiza sprite jogador ##
    la t1, IMAGEM_JOGADOR_cima		# pega o endereco de "IMAGEM_JOGADOR_cima" e coloca em t1
    la t5, IMAGEM_JOGADOR		# pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
    sw t1, 0(t5)			# coloca o endereco de t1 no endereco de t5 
    
    j MOVIMENTA_INIMIGOS      # Encerra ATUALIZA_FRAME.s		


CASO_TECLA_a:
    li t2, 97		            # Pegue o valor 'a' na tabela ASCII	
    bne s0, t2, CASO_TECLA_s	# Se a tecla pressionada nao foi 'a'
    
    la s0, POSICAO_JOGADOR		# Pegue endereco POSICAO_ATUAL_JOGADOR
    lw t0, 0(s0)                # Pegue conteudo POSICAO_ATUAL_JOGADOR
    addi t0, t0, -1             # Adicone o offset

    la s1, TILEMAP_MUTAVEL  # Pegue endereco inicial do TILEMAP
    add s1, s1, t0          # Pegue endereco da matriz POSICAO_ATUAL_JOGADOR + OFFSET
    lb s3, 0(s1)            # Pegue conteudo da matriz POSICAO_ATUAL_JOGADOR + OFFSET


    ## EVENTO: COLISAO BLOCOS ##
    li t2, 1                            # Pegue o valor 1
    beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco indestrutivel (Pilastra)
    li t2, 3                            # Pegue o valor 3
    beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)

    li t2, 4
    sb t2, 0(s1)    # Movimenta o JOGADOR

    addi s1, s1, 1	    # Retira offset
    li t2, 0        	# Pegue o valor 0
    sb t2, 0(s1)    	# Apague rastro do Jogador

    sw t0, 0(s0)    # Atualiza POSICAO_JOGADOR
    
    ## atualiza sprite jogador ##
    la t1, IMAGEM_JOGADOR_esquerda	# pega o endereco de "IMAGEM_JOGADOR_esquerda" e coloca em t1
    la t5, IMAGEM_JOGADOR		# pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
    sw t1, 0(t5)			# coloca o endereco de t1 no endereco de t5

    j MOVIMENTA_INIMIGOS      # Encerra ATUALIZA_FRAME.s		

CASO_TECLA_s:
    li t2, 115		            # Pegue o valor S na tabela ASCII	
    bne s0, t2, CASO_TECLA_d	# Se a tecla pressionada nao foi 's'
    
    la s0, POSICAO_JOGADOR		# Pegue endereco POSICAO_ATUAL_JOGADOR
    lw t0, 0(s0)                # Pegue conteudo POSICAO_ATUAL_JOGADOR
    addi t0, t0, 20             # Adicone o offset

    la s1, TILEMAP_MUTAVEL  # Pegue endereco inicial do TILEMAP
    add s1, s1, t0          # Pegue endereco da matriz POSICAO_ATUAL_JOGADOR + OFFSET
    lb s3, 0(s1)            # Pegue conteudo da matriz POSICAO_ATUAL_JOGADOR + OFFSET


    ## EVENTO: COLISAO BLOCOS ##
    li t2, 1                            # Pegue o valor 1
    beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco indestrutivel (Pilastra)
    li t2, 3                            # Pegue o valor 3
    beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)

    li t2, 4
    sb t2, 0(s1)    # Movimenta o JOGADOR

    addi s1, s1, -20	# Retira offset
    li t2, 0        	# Pegue o valor 0
    sb t2, 0(s1)    	# Apague rastro do Jogador

    sw t0, 0(s0)    # Atualiza POSICAO_JOGADOR
    
    ## atualiza sprite jogador ##
    la t1, IMAGEM_JOGADOR_baixo		# pega o endereco de "IMAGEM_JOGADOR_esquerda" e coloca em t1
    la t5, IMAGEM_JOGADOR		# pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
    sw t1, 0(t5)			# coloca o endereco de t1 no endereco de t5

    j MOVIMENTA_INIMIGOS      # Encerra ATUALIZA_FRAME.s		

CASO_TECLA_d:
    li t2, 100		            # Pegue o valor 'd' na tabela ASCII	
    bne s0, t2, CASO_TECLA_L	# Se a tecla pressionada nao foi 'd'    # Corrigir PRIMEIRO salto para CASO_TECLA_L, DEPOIS para CASO_TECLA_L
    
    la s0, POSICAO_JOGADOR		# Pegue endereco POSICAO_ATUAL_JOGADOR
    lw t0, 0(s0)                # Pegue conteudo POSICAO_ATUAL_JOGADOR
    addi t0, t0, 1              # Adicone o offset

    la s1, TILEMAP_MUTAVEL  # Pegue endereco inicial do TILEMAP
    add s1, s1, t0          # Pegue endereco da matriz POSICAO_ATUAL_JOGADOR + OFFSET
    lb s3, 0(s1)            # Pegue conteudo da matriz POSICAO_ATUAL_JOGADOR + OFFSET
    
    
    ## EVENTO: COLISAO BLOCOS ##
    li t2, 1                            # Pegue o valor 1
    beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco indestrutivel (Pilastra)
    li t2, 3                            # Pegue o valor 3
    beq s3, t2, MOVIMENTA_INIMIGOS    # Conteudo na nova posicao eh Bloco destrutivel (Tijolo)

    li t2, 4
    sb t2, 0(s1)    # Movimenta o JOGADOR

    addi s1, s1, -1	    # Retira offset
    li t2, 0        	# Pegue o valor 0
    sb t2, 0(s1)    	# Apague rastro do Jogador

    sw t0, 0(s0)    # Atualiza POSICAO_JOGADOR
    
    ## atualiza sprite jogador ##
    la t1, IMAGEM_JOGADOR_direita	# pega o endereco de "IMAGEM_JOGADOR_direita" e coloca em t1
    la t5, IMAGEM_JOGADOR		# pega o endereco de "IMAGEM_JOGADOR" e coloca em t5
    sw t1, 0(t5)			# coloca o endereco de t1 no endereco de t5

    j MOVIMENTA_INIMIGOS      # Encerra ATUALIZA_FRAME.s		

# CASO_TECLA_K:
# 		li t2, 75		            # Pegue o valor 'L' na tabela ASCII	
# 		bne s0, t2, CASO_TECLA_L	# Se a tecla pressionada nao foi 'K'

        ## EVENTO : MATA INIMIGOS ##

# 		la s0, IMAGEM_3		# Se o byte atual == 2, pegue a imagem_2
# 		j FIM_ATUALIZA_TILEMAP      # Encerra ATUALIZA_FRAME.s		

CASO_TECLA_L:
    li t2, 76		            # Pegue o valor 'L' na tabela ASCII	
    bne s0, t2, CASO_TECLA_P	# Se a tecla pressionada nao foi 'L'

    ## EVENTO : LIMPA BLOCOS ##
    li t0, 41		    # Primeira matriz do APAGA_BLOCOS
    li t1, 278		    # Ultima matriz do tilemap

    LOOP_TILEMAP_APAGA_BLOCOS:
        bgt t0, t1, MOVIMENTA_INIMIGOS		# Enquanto t0 < ultima matriz do tilemap, faca o abaixo

        la s2, TILEMAP_MUTAVEL	# Pegue o endereco do Tilemap
        add s2, s2, t0	        # Itere o endereco do byte no tilemap
        lb t5, 0(s2)	        # Valor da matriz no Tilemap

    ## O caso abaixo substitui o tijolo por um espaço vazio ##
    CASO_2_APAGA_BLOCOS:
        li t2, 3		                            # Pegue o valor 0
        bne t5, t2, ITERA_LOOP_TILEMAP_APAGA_BLOCOS	# Compare com o valor no byte atual do Tilemap

        li t2, 0        # Pegue o valor 0
        sb t2, 0(s2)    # Atualiza matriz Tijolo para Campo vazio 

    ITERA_LOOP_TILEMAP_APAGA_BLOCOS:
        addi t0, t0, 1	                      # t0++
        li s4, 20                             # s4 = 20
        rem s4, t0, s4                        # s4 = t0 % 20
        li s5, 19                             # s5 = 19
        bne s4, s5, LOOP_TILEMAP_APAGA_BLOCOS # Se s4 != 19 -> LOOP_TILEMAP_CAMPO
        addi t0, t0, 2                        # s4 == 19 -> Some 2 : Pule colunas indestrutiveis
        j LOOP_TILEMAP_APAGA_BLOCOS           # Retorne para a verificacao do Loop que percorre o Tilemap

CASO_TECLA_P:
    li t2, 80			# Pegue o valor 'P' na tabela ASCII	
    # O ultimo caso possui uma comparacao oposta dos demais (!= ao inves de ==).
    bne s0, t2, MOVIMENTA_INIMIGOS	# Se a tecla pressionada nao foi 'P'

    ## EVENTO : PROXIMA_FASE (POR ENQUANTO ENCERRA O JOGO) ##
    j FIM_GAME_LOOP_FASE_1              # Encerra Game_Loop
    la s0, IMAGEM_JOGADOR			    # Se o byte atual == 3, pegue a imagem_3

MOVIMENTA_INIMIGOS:     # Por enquanto ainda nao ha inimigos

FIM_ATUALIZA_TILEMAP:
