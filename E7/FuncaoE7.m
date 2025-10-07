function [y, zf] = FuncaoE7(x, b, zi)
% x - sinal a ser filtrado (bloco de entrada atual)
% b - coeficientes do filtro FIR (projetados anteriormente)
% zi - condições iniciais do filtro (memória do bloco anterior)
% y - sinal filtrado (bloco de saída)
% zf - condições finais do filtro (para a próxima iteração)

% 1. PREPARAÇÃO DOS VETORES
N = length(b);             % Número de coeficientes do filtro
M = length(x);             % Tamanho do bloco de entrada
y = zeros(1, M);           % Pré-aloca o vetor de saída

% Junta a memória do filtro (zi) com o bloco de áudio atual (x)
% para criar um buffer contínuo para os cálculos.
% O x' transpõe o vetor coluna de entrada para um vetor linha.
buffer = [zi, x'];

% 2. IMPLEMENTAÇÃO DA FORMA DIRETA (SOMA DE CONVOLUÇÃO)
% Este laço calcula cada amostra de saída y[n] do bloco atual.
for n = 1:M
    soma = 0;
    % Este laço interno realiza a soma ponderada das amostras do buffer
    % multiplicadas pelos coeficientes 'b'.
    for k = 1:N
        soma = soma + b(k) * buffer(n + N - k);
    end
    y(n) = soma;
end

% 3. ATUALIZAÇÃO DA MEMÓRIA DO FILTRO
% As últimas N-1 amostras do buffer são salvas em 'zf'.
% Elas serão usadas como as condições iniciais ('zi') na próxima
% vez que esta função for chamada.
zf = buffer(M+1 : end);

end