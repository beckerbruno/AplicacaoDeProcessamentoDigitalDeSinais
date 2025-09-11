function [y] = FuncaoE5(x)
% Item b.1) Retificador de Onda Completa
% A função abs() do MATLAB calcula o módulo (valor absoluto) do sinal.
y = abs(x);
end

%function [y] = FuncaoE5(x)
% Item b.2) Retificador de Meia Onda
% Esta lógica mantém o valor original de y (que é igual a x)
% somente onde y (ou x) for maior ou igual a zero.
% Onde for negativo, o valor é substituído por 0.
%y = x;
%y(y < 0) = 0;
%end

%function [y] = FuncaoE5(x)
% Item b.3) Onda Quadrada Vinculada
% A função sign() retorna +1 para valores positivos, -1 para negativos
% e 0 para zero. Isso cria uma onda quadrada perfeitamente em fase
% com o sinal de entrada.
% Multiplicamos por 0.5 para ajustar a amplitude para o intervalo [-0.5, 0.5].
%y = 0.5 * sign(x);
%end
