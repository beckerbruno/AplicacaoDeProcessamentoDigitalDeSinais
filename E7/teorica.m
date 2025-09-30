clear; clc; close all;

grupo = 1;
fis = 1.5e3;
fi  = 1.8e3;
fs  = 2.2e3;
fss = 2.5e3;
fa  = 32e3;

fprintf('Projetando o filtro para o Grupo %d...\n\n', grupo);

% =========================================================================
% (a) Determinar os coeficientes da função de transferência
% =========================================================================

% Calcular frequências normalizadas (Equações 7-11)
fc1 = (fis + fi) / 2;
fc2 = (fs + fss) / 2;

delta_f = min(fi - fis, fss - fs);

delta_Omega = 2 * pi * delta_f / fa;

% Ordem do filtro (Equação 12 para Blackman)
L = ceil(12*pi / delta_Omega);

if rem(L, 2) == 0
    L = L + 1; % Garante que L seja ímpar
end
fprintf('Ordem do filtro calculada (L): %d\n', L);

% --- 3. Projetar o filtro usando funções do MATLAB ---
% Frequências de corte normalizadas para fir1 (intervalo [0, 1])
Wn = [fc1 fc2] / (fa/2);

% Janela de Blackman de ordem L
win = blackman(L);

b = fir1(L-1, Wn, 'bandpass', win);

fprintf('Coeficientes do filtro (b) calculados:\n');
disp(b);
fprintf('\nO vetor de coeficientes "b" foi criado no seu workspace.\n');
fprintf('Você irá copiar este vetor para o arquivo ExpE7.m no próximo passo.\n\n');

% =========================================================================
% (b) Plotar a resposta em frequência do filtro
% =========================================================================
fprintf('Abrindo a Ferramenta de Análise de Filtros (fvtool)...\n');
fvtool(b, 1, 'Fs', fa);