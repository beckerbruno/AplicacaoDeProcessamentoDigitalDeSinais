% =========================================================================
% Script para a Atividade Teórica (a) e (b)
% Projeto de Filtro FIR Passa-Banda com Janela de Blackman
% =========================================================================
clear; clc; close all;

% --- PARÂMETROS DO SEU GRUPO (Tabela do PDF) ---
% Exemplo preenchido para o Grupo 5. Altere para os valores do seu grupo.
grupo = 1;
fis = 1.5e3; % Frequência inferior da banda de rejeição (Hz)
fi  = 1.8e3; % Frequência inferior da banda de passagem (Hz)
fs  = 2.2e3; % Frequência superior da banda de passagem (Hz)
fss = 2.5e3; % Frequência superior da banda de rejeição (Hz)
fa  = 32e3;  % Frequência de amostragem (Hz)

fprintf('Projetando o filtro para o Grupo %d...\n\n', grupo);

% =========================================================================
% (a) Determinar os coeficientes da função de transferência
% =========================================================================

% --- 1. Calcular frequências normalizadas (Equações 7-11) ---
% Nota: As fórmulas do PDF são para frequências normalizadas [0, 2*pi]
% O MATLAB trabalha com frequências normalizadas [0, 1] onde 1 = fa/2.
% Vamos usar as fórmulas do PDF e depois adaptar para o MATLAB.

% Frequências de corte ideal do filtro (centro das bandas de transição)
fc1 = (fis + fi) / 2;
fc2 = (fs + fss) / 2;

% Banda de transição (a menor das duas)
delta_f = min(fi - fis, fss - fs);

% Normalizando a banda de transição para o intervalo [0, 2*pi]
delta_Omega = 2 * pi * delta_f / fa;

% --- 2. Calcular a ordem do filtro (Equação 12 para Blackman) ---
L = ceil(12*pi / delta_Omega);

% A ordem do filtro (L) para um filtro FIR de fase linear tipo I deve ser ímpar.
if rem(L, 2) == 0
    L = L + 1; % Garante que L seja ímpar
end
fprintf('Ordem do filtro calculada (L): %d\n', L);

% --- 3. Projetar o filtro usando funções do MATLAB ---
% O MATLAB pode fazer todo o projeto automaticamente com a função fir1,
% que é a implementação da técnica das janelas.

% Frequências de corte normalizadas para fir1 (intervalo [0, 1])
Wn = [fc1 fc2] / (fa/2);

% Janela de Blackman de ordem L
win = blackman(L);

% Projeto do filtro FIR usando a técnica das janelas
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