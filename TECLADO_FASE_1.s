##################################################################
############ REALIZA O POOL NON-BLOCKING DO TECLADO ##############
##################################################################
    la s0, TECLA_LIDA           # Pegue o endereco de TECLA_LIDA

    # Tenta ler um comando do teclado
    lui t1, 0xFF200		        # t0 = Endereco de Controle do KDMMIO
	lw t0, 0(t1)                # Pega o Conteudo do Endereco de Controle do KDMMIO
	andi t0, t0, 1			    # Verifica se o ultimo bit de t0 == 1
	beqz t0, FIM_ZERO_FASE_1	# Se ultimo bit de t0 == 1: Tecla nova foi lida -> Guarda e ecoa tecla; 0 : Nao foi lida nenhuma tecla->Encerra

    # Leu alguma tecla
	lw t0, 4(t1)				# Pegue o conteudo da nova tecla lida
	sw t0, 0(s0)				# Salva o conteudo de t0 em TECLA_LIDA
	sw t0, 12(t1)				# Ecoa a tecla lida no display do KDMMIO
	j FIM_TECLADO_FASE_1		# Sai da funcao com retorno diferente de 0

# Nao leu nenhuma tecla
FIM_ZERO_FASE_1:         
    li s1, 0                    # Pegue o valor 0
    sw s1, 0(s0)                # Como nenhum caractere foi lido, "TECLA_LIDA = 0", ou seja, "Nao faca nada"				    

# Sai da funcao 
FIM_TECLADO_FASE_1:
    #lw a0, 0(s0)
    #li a7, 11
    #ecall
