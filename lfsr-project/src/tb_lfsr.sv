module tb_lfsr;
  localparam seed = 1;            // Valor de inicialização do LFSR (seed)
  logic clk, rst;                 // Sinais de clock e reset
  logic [31:0] q;                 // Saída do LFSR

  localparam N = 100;             // Número de vetores de teste
  logic [31:0] testvectors [N-1:0]; // Array para armazenar os vetores de teste
  logic [31:0] expected_q;        // Valor esperado de q

  // Instância do LFSR (DUT - Device Under Test)
  lfsr #(seed) dut(clk, rst, q);

  // Geração do clock (toggle a cada 5 unidades de tempo)
  always #5 clk = ~clk;

  // Bloco inicial para simulação
  initial begin
    // Geração de arquivo de dump para visualização da simulação
    $dumpfile("dump.vcd");
    $dumpvars(0, clk, q);

    // Inicialização dos sinais de clock e reset
    clk = 1; rst = 0;
    rst = 1; @(posedge clk); rst = 0;

    // Leitura dos vetores de teste a partir do arquivo "testvectors.txt"
    $readmemb("testvectors.txt", testvectors, 0, N-1);

    // Loop para comparar a saída do LFSR com os valores esperados
    for (int i = 0; i < N; i++) begin
      expected_q = testvectors[i];  // Pega o valor esperado
      @(posedge clk);               // Espera pela borda positiva do clock

      // Verifica se o valor de q corresponde ao esperado
      assert(q === expected_q);
        else $error(
          "Erro na linha %0d: q=%b, expected_q=%b",
          i+1, q, expected_q
        );
    end

    // Finaliza a simulação
    $finish;
  end
endmodule
