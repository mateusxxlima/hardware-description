module CONTROLLER (
  input clk,
  input reset,
  output H,
  output load_x,
  output load_s,
  output load_h,
  output reg [1:0] sel_m0,
  output reg [1:0] sel_m1,
  output reg [1:0] sel_m2,
  output done
);

  reg H, load_x, load_s, load_h, done;
  reg [3:0] STATE = 2;

  always @(posedge clk or reset) begin
    // Se mantem em estado de reset
    if (reset == 1'b1) begin
      H = 1'b0;
      load_x = 1'b0;
      load_s = 1'b0;
      load_h = 1'b0;
      sel_m0 = 2'b00;
      sel_m1 = 2'b00;
      sel_m2 = 2'b00;
      STATE = 2;
    end else begin
      case (STATE)
        2: begin
          H = 1'b0;
          load_x = 1'b1; //Carrega o X
          load_s = 1'b0;
          load_h = 1'b0;
          sel_m0 = 2'b00;
          sel_m1 = 2'b00;
          sel_m2 = 2'b00;
          done = 1'b0;
          STATE = STATE + 1;
        end
        3: begin
          H = 1'b1; // H = 1 ULA multiplica os valores que recebe
          load_x = 1'b0;
          load_s = 1'b1; // load_s = 1 Permite armazenar o resultado de X²
          load_h = 1'b0;
          sel_m0 = 2'b00;
          sel_m1 = 2'b01; // seleciona X
          sel_m2 = 2'b00; // também seleciona X
          done = 1'b0;
          STATE = STATE + 1;
        end
        4: begin
          H = 1'b1;
          load_x = 1'b0;
          load_s = 1'b1; // permite carregar o resultado novamente
          load_h = 1'b0;
          sel_m0 = 2'b01; // seleciona A
          sel_m1 = 2'b00; // seleciona o A que está na saída de m0
          sel_m2 = 2'b10; // seleciona X² que está no registrador S
          done = 1'b0;
          STATE = STATE + 1;
        end
        5: begin
          H = 1'b1;
          load_x = 1'b0;
          load_s = 1'b0;
          load_h = 1'b1; // permite carregar X*B
          sel_m0 = 2'b10; // seleciona B
          sel_m1 = 2'b00; // seleciona B que está na saída de m0
          sel_m2 = 2'b00; // seleciona o X para multiplicar com B
          done = 1'b0;
          STATE = STATE + 1;
        end
        6: begin
          H = 1'b0; // H = 0 a partir de agora usaremos a ULA para somar valores
          load_x = 1'b0;
          load_s = 1'b1; // permite carregar a soma dos valores reg_h e reg_s em reg_s novamente
          load_h = 1'b0;
          sel_m0 = 2'b00;
          sel_m1 = 2'b11; // seleciona a saída do registrador H
          sel_m2 = 2'b10; // seleciona a saída do registrador S
          done = 1'b0;
          STATE = STATE + 1;
        end
        7: begin
          H = 1'b0;
          load_x = 1'b0;
          load_s = 1'b1; // s receberá o resultado da soma novamente
          load_h = 1'b0;
          sel_m0 = 2'b11; // seleciona C para somar com o somatório dos dois primeiros termos 
          sel_m1 = 2'b00; // seleciona o C que está na saída de m0
          sel_m2 = 2'b10; // seleciona a saída de reg s que contém o somatório dos dois primeiros termos
          done = 1'b0;
          STATE = STATE + 1;
        end
        8: begin
          H = 1'b1;
          load_x = 1'b0;
          load_s = 1'b1;
          load_h = 1'b0;
          sel_m0 = 2'b00;
          sel_m1 = 2'b01;
          sel_m2 = 2'b00;
          done = 1'b1; // done recebe 1 avisando que o resultado está pronto
          STATE = 2;
        end
      endcase
    end
  end

endmodule