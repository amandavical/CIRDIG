NUM_TESTCASES = 100  # Número de vetores de teste a serem gerados

# Função para converter um número em binário de comprimento fixo
def bin_conversion(num, width):
    return list(map(int, bin(num)[2:].zfill(width)))

# Classe que implementa o LFSR em Python
class LFSR:
    WIDTH = 32  # Tamanho do registrador LFSR

    # Inicializa o LFSR com o seed fornecido
    def __init__(self, seed = 1):
        self.q = bin_conversion(seed, width = self.WIDTH)

    # Função que executa um ciclo do LFSR
    def run(self):
        tmp = self.q[::-1]  # Inverte a lista de bits
        feedback = tmp[0] ^ tmp[1] ^ tmp[21] ^ tmp[31]  # Calcula o feedback usando os taps
        self.q = [feedback] + self.q[:-1]  # Atualiza o registrador com o feedback no MSB
        return ''.join(map(str, self.q))  # Retorna o valor de q como string binária

# Função principal para gerar os vetores de teste
def main():
    lfsr = LFSR()  # Cria uma instância do LFSR
    # Gera os vetores de teste e salva em 'testvectors.txt'
    testvectors = [lfsr.run() for _ in range(NUM_TESTCASES)]
    with open('testvectors.txt', 'w') as file:
        file.write('\n'.join(testvectors))

# Executa o script
if __name__ == '__main__':
    main()
