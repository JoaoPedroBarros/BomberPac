import csv

arquivo_csv = 'saida.csv'  # Nome do seu CSV
saida_data = 'notas.data'  # Arquivo de saída

notas = []

with open(arquivo_csv, 'r') as f:
    reader = csv.reader(f, skipinitialspace=True)
    eventos = list(reader)  # Lê todos os eventos

# Procura por Note_on e seus Note_off correspondentes
for i, linha in enumerate(eventos):
    if len(linha) >= 6 and 'Note_on' in linha[2] and int(linha[5]) > 0:
        nota = int(linha[4])
        tempo_ligada = int(linha[1])
        
        # Procura o Note_off mais próximo para a mesma nota
        for j in range(i + 1, len(eventos)):
            if (len(eventos[j]) >= 6 and
                'Note_off' in eventos[j][2] and
                eventos[j][4] == linha[4]):  # Mesma nota
                duracao = int(eventos[j][1]) - tempo_ligada
                notas.extend([nota, duracao])
                break

# Salva o arquivo .data
with open(saida_data, 'w') as f:
    f.write(f"TAMANHO_MUSICA: .word {len(notas)//2}\n")
    f.write("NOTAS: " + ",".join(map(str, notas)) + "\n")

print(f"Notas extraídas: {len(notas)//2}")
print(f"Arquivo '{saida_data}' gerado!")