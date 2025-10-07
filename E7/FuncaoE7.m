% Aplicacoes de Processamento Digital de Sinais - 4456S-04
% Experięncia E7: Projeto e implementaçăo de filtros FIR
% Prof. Denis Fernandes
% Ultima atualizacao: 30/04/2019

function [y, zf] = FuncaoE7(x, b, zi)
% x - sinal a ser filtrado
% b - coeficientes do filtro FIR
% zi - condicoes iniciais do filtro
% zf - condicoes finais do filtro
% y - sinal filtrado

% IMPLEMENTAÇÃO EM FORMA DIRETA (Equação 3 do manual)
%********************************************

N = length(b);
L = length(x);
y = zeros(size(x));
zf = zi;

% Implementação da equação de diferenças: y[n] = sum(b[k] * x[n-k])
for n = 1:L
    % Calcula y[n] = b[0]*x[n] + b[1]*x[n-1] + ... + b[N-1]*x[n-(N-1)]
    y(n) = b(1) * x(n); % b[0]*x[n]
   
    for k = 2:min(n, N)
        y(n) = y(n) + b(k) * x(n-k+1);
    end
   
    % Usa condições iniciais para amostras anteriores
    for k = n+1:N
        if (k-n) <= length(zi)
            y(n) = y(n) + b(k) * zi(k-n);
        end
    end
end

% Atualiza condições finais
if L >= N
    zf = x(L-N+2:L);
else
    zf = [x(2:L) zi(1:length(zi)-L+1)];
end

% Usando a função filter do MATLAB
%[y, zf] = filter(b, 1, x, zi);

%********************************************

end