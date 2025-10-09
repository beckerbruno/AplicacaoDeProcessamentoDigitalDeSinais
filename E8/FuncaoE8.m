% Aplicacoes de Processamento Digital de Sinais - 4456S-04
% Experi�ncia E8: Projeto e implementa��o de filtros IIR
% Prof. Denis Fernandes 
% Ultima atualizacao: 07/05/2019

function [y, zo] = FuncaoE8(x, b, a, zi)
%  x - sinal a ser filtrado
% zi - condicoes iniciais para o filtro
% zi - condicoes finais resultante da filtragem
%  y - sinal filtrado

% filtragem
%********************************************

[y zo] = filter(b,a,x,zi);

%********************************************

end




function [y, zo] = FuncaoE8(x, b, a, zi)
% IMPLEMENTAÇÃO MANUAL DA FORMA DIRETA II PARA O ITEM (C)

    % Garante que os vetores de estado e coeficientes sejam linhas
    zi = zi(:)';
    a = a(:)';
    b = b(:)';
    
    % Pré-aloca o vetor de saída
    y = zeros(size(x));
    
    % 'w' é o vetor de estado (a memória do filtro). Ele é inicializado
    % com as condições iniciais do bloco anterior.
    w = zi;
    
    % Itera sobre cada amostra do bloco de entrada 'x'
    for n = 1:length(x)
        % 1. Calcula o estado w[n] atual (parte recursiva)
        % w_atual = x[n] - (a1*w[n-1] + a2*w[n-2] + ...)
        w_atual = x(n) - sum(a(2:end) .* w);
        
        % 2. Calcula a saída y[n] (parte não-recursiva)
        % y[n] = b0*w[n] + b1*w[n-1] + b2*w[n-2] + ...
        y(n) = sum(b .* [w_atual, w(1:end-1)]);
        
        % 3. Atualiza o vetor de estado para a próxima iteração
        % O novo estado se torna o estado "passado"
        w = [w_atual, w(1:end-1)];
    end
    
    % As condições finais são o último estado do vetor 'w'
    zo = w;
end
