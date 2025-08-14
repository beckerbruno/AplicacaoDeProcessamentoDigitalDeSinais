% =========================================================================
% Atividade Prática (c)
% Cálculo da DFT de x3[n] com a função FFT
% =========================================================================
clear all; clc; close all;

% 1. Definição do sinal base
n0 = 16;
x3_base = ones(1, n0); % Sinal x3[n] = u[n] - u[n-n0] 

% 2. Cálculo e Gráfico para N = 256
N1 = 256;
% A função fft com N > length(sinal) aplica preenchimento com zeros (zero-padding)
X3_256 = fft(x3_base, N1);
% Vetor de frequência digital para o gráfico
k1 = 0:N1-1;
Omega1 = 2*pi*k1/N1;

% 3. Cálculo e Gráfico para N = 16
N2 = 16;
% Aqui N é igual ao tamanho do sinal
X3_16 = fft(x3_base, N2);
k2 = 0:N2-1;
Omega2 = 2*pi*k2/N2;

% 4. Cálculo e Gráfico para N = 8
N3 = 8;
% Aqui N é menor que o tamanho do sinal, então a fft TRUNCA o sinal
X3_8 = fft(x3_base, N3); % Usa apenas os 8 primeiros pontos de x3_base
k3 = 0:N3-1;
Omega3 = 2*pi*k3/N3;

% 5. Apresentação dos gráficos
figure('Name', 'DFT de x3[n] com diferentes valores de N');

% Gráfico N=256
subplot(3, 1, 1);
plot(Omega1/pi, abs(X3_256));
title('Módulo da DFT de x_3[n] com N = 256 pontos');
ylabel('|X_k|');
grid on;

% Gráfico N=16
subplot(3, 1, 2);
stem(Omega2/pi, abs(X3_16), 'filled');
title('Módulo da DFT de x_3[n] com N = 16 pontos');
ylabel('|X_k|');
grid on;

% Gráfico N=8
subplot(3, 1, 3);
stem(Omega3/pi, abs(X3_8), 'filled');
title('Módulo da DFT de x_3[n] com N = 8 pontos (sinal truncado)');
xlabel('Frequência Normalizada (\times\pi rad/amostra)');
ylabel('|X_k|');
grid on;

% 6. Relação entre os valores (explicação textual)
disp('Relação entre os valores de N:');
disp('N=256: O preenchimento com zeros (zero-padding) aumenta a RESOLUÇÃO da frequência.');
disp('Isso significa que temos mais pontos sobre a curva da DTFT do sinal original de 16 amostras.');
disp('A forma do gráfico se assemelha a uma função sinc amostrada 256 vezes.');
disp('');
disp('N=16: O número de pontos da DFT é igual ao comprimento do sinal. ');
disp('Neste caso específico, a DFT amostra a DTFT exatamente nos seus cruzamentos por zero (exceto em k=0).');
disp('Por isso, o resultado é 16 em k=0 e praticamente zero para os outros k.');
disp('');
disp('N=8: O número de pontos da DFT é menor que o sinal. A função fft TRUNCA o sinal,');
disp('considerando apenas os 8 primeiros pontos. O resultado é a DFT de um pulso de 8 amostras, não do sinal original.');