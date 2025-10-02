function [y, zf] = FuncaoE7(x, b, zi)
% x - sinal a ser filtrado (bloco de entrada atual)
% b - coeficientes do filtro FIR
% zi - condições iniciais do filtro (amostras finais do bloco anterior)
% y - sinal filtrado (bloco de saída)
% zf - condições finais do filtro (para a próxima iteração)

N = length(b);             % Ordem do filtro + 1 (número de coeficientes)
M = length(x);             % Tamanho do bloco de entrada
y = zeros(1, M);           % Pré-aloca o vetor de saída com zeros

buffer = [zi, x];

for n = 1:M
    soma = 0;
    for k = 1:N
        soma = soma + b(k) * buffer(n + N - k);
    end
    y(n) = soma;
end

zf = buffer(M+1 : end);

end