% =========================================================================
% Atividade Prática (a)
% Cálculo da DTFT do sinal x1[n]
% =========================================================================
clear all; clc; close all;

% 1. Definição do sinal e dos vetores
n = -5:5;                   % Vetor de tempo discreto para x1[n]
x1 = ones(1, length(n));    % Sinal x1[n] é 1 no intervalo de n

% Frequência digital Omega de -2*pi a 2*pi com 1000 pontos
Omega = linspace(-2*pi, 2*pi, 1000);

% 2. Cálculo da DTFT usando a definição (forma vetorizada)
% A equação é X(Ω) = Σ x[n] * exp(-j*Ω*n)
% Em MATLAB, isso pode ser feito eficientemente com multiplicação de matriz
exp_matrix = exp(-1j * n' * Omega); % Matriz de exponenciais complexas
X1 = x1 * exp_matrix;               % Calcula a DTFT

% 3. Apresentação dos gráficos
figure('Name', 'DTFT de x1[n]');

% Gráfico do Módulo
subplot(2, 1, 1);
plot(Omega/pi, abs(X1));
title('Módulo de X_1(\Omega)');
xlabel('Frequência Normalizada (\times\pi rad/amostra)');
ylabel('|X_1(\Omega)|');
grid on;

% Gráfico da Fase
subplot(2, 1, 2);
plot(Omega/pi, angle(X1));
title('Fase de X_1(\Omega)');
xlabel('Frequência Normalizada (\times\pi rad/amostra)');
ylabel('Fase (radianos)');
grid on;

% 4. Comparação com a teoria (ver janela de comando)
% Para comparar com a Atividade Teórica (item a)
disp('Valores para comparação:');
% Encontra o índice mais próximo de Omega = 0
[~, idx_0] = min(abs(Omega - 0));
fprintf('Valor calculado de |X1(0)|: %.4f (Teórico: 11)\n', abs(X1(idx_0)));

% Encontra o índice mais próximo de Omega = 1
[~, idx_1] = min(abs(Omega - 1));
fprintf('Valor calculado de X1(1) (módulo): %.4f\n', abs(X1(idx_1)));

% Encontra o índice mais próximo de Omega = pi
[~, idx_pi] = min(abs(Omega - pi));
fprintf('Valor calculado de X1(pi) (módulo): %.4f\n', abs(X1(idx_pi)));