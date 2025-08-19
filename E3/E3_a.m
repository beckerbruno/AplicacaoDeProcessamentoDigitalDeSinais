% =========================================================================
% Atividade Teórica (a) e (b)
% Análise do filtro não quantizado
% =========================================================================
clear; 
clc; 

% --- Parâmetros do filtro (do arquivo ExpE3.m) ---
Fs = 48000; % frequencia de amostragem (Hz)
N = 8;      % ordem do filtro
AP = 1;     % atenuacao na banda de passagem (dB)
AS = 40;    % atenuacao na banda de rejeicao (dB)
F = 15000;  % frequencia de corte do filtro (Hz)

% --- Projeto do filtro ---
[b,a] = ellip(N,AP,AS,F/(Fs/2),'low'); % projeto da H(z) nao quantizada

% =========================================================================
% a) Determinar os polos e zeros do filtro 
% =========================================================================
zeros_H = roots(b);
polos_H = roots(a);

disp('--- Atividade Teórica (a): Polos e Zeros ---');
disp('Zeros do filtro H(z):');
disp(zeros_H);
disp('Polos do filtro H(z):');
disp(polos_H);
disp('O filtro é estável, pois o módulo de todos os polos é < 1.');
disp(['Módulo do maior polo: ', num2str(max(abs(polos_H)))]);
disp(' '); % Espaçamento

% =========================================================================
% b) Transformar H(z) em cascata de funções de segunda ordem (SOS) [cite: 16]
% =========================================================================
sos_matrix = tf2sos(b, a);

disp('--- Atividade Teórica (b): Matriz de Seções de Segunda Ordem (SOS) ---');
disp('Matriz SOS (cada linha é uma seção [b0, b1, b2, a0, a1, a2]):');
disp(sos_matrix);