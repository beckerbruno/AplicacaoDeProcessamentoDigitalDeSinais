% =========================================================================
% Atividade Prática (b)
% Cálculo da DTFT Inversa de X2(Ω) por integração numérica
% =========================================================================
clear all; clc; close all;

% 1. Definição do intervalo de n e da frequência para integração
n_vec = -1:10; % Intervalo de n para calcular x2[n] 
x2 = zeros(1, length(n_vec)); % Vetor para armazenar os resultados

% Para uma boa precisão na integral, usamos mais pontos
Omega_int = linspace(-pi, pi, 4096); % Vetor de frequência de -pi a pi

% 2. Cálculo de X2(Ω)
% Expressão dada no enunciado 
X2_Omega = 2 ./ (1 - 0.5 * exp(-1j * Omega_int));

% 3. Loop para calcular x2[n] para cada valor de n
for i = 1:length(n_vec)
    current_n = n_vec(i);
    
    % O integrando da DTFT inversa é X(Ω) * exp(j*Ω*n)
    integrand = X2_Omega .* exp(1j * Omega_int * current_n);
    
    % Usa trapz para integração numérica: ∫ y dx -> trapz(x, y)
    integral_val = trapz(Omega_int, integrand);
    
    % Aplica o fator 1/(2*pi) da fórmula da DTFT inversa
    x2(i) = (1 / (2*pi)) * integral_val;
end

% 4. Apresentação do gráfico
figure('Name', 'DTFT Inversa de X2(Ω)');
% Usamos stem para gráficos de sinais em tempo discreto
% Usamos real() para remover pequenos erros numéricos imaginários
stem(n_vec, real(x2), 'filled');
title('Sinal x_2[n] obtido via DTFT Inversa Numérica');
xlabel('Amostra (n)');
ylabel('Amplitude x_2[n]');
grid on;

% 5. Comparação com a teoria (ver janela de comando)
% A DTFT inversa teórica é x2[n] = 2*(0.5^n)*u[n]
disp('Valores para comparação:');
fprintf('Valor calculado de x2[0]: %.4f (Teórico: 2.0)\n', real(x2(n_vec == 0)));
fprintf('Valor calculado de x2[1]: %.4f (Teórico: 1.0)\n', real(x2(n_vec == 1)));
fprintf('Valor calculado de x2[2]: %.4f (Teórico: 0.5)\n', real(x2(n_vec == 2)));