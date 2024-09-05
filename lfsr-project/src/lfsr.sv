module lfsr #(parameter seed = 1)(
  input logic clk, rst,          // Entrada: sinal de clock e reset
  output logic [31:0] q          // Saída: número pseudo-aleatório de 32 bits
);
  logic feedback;                 // Variável para armazenar o valor de feedback
  logic [31:0] q_reg, q_next;     // Registradores para armazenar o valor atual e o próximo valor de q

  // Sempre que o clock ou reset subir, atualiza o registrador q_reg
  always_ff @(posedge clk, posedge rst) begin
    if (rst) begin
      q_reg <= seed;              // Quando resetado, inicializa o registrador com o seed
    end
    else begin
      q_reg <= q_next;            // Atualiza o registrador com o próximo valor
    end
  end

  // Calcula o valor de feedback usando taps (bits 0, 1, 21, 31)
  assign feedback = q_reg[0] ^ q_reg[1] ^ q_reg[21] ^ q_reg[31];
  // Atualiza q_next movendo os bits e inserindo o feedback no bit mais significativo
  assign q_next = {feedback, q_reg[31:1]};
  // Saída do registrador
  assign q = q_reg;
endmodule
