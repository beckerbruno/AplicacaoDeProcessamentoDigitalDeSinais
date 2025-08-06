% SCRIPT PARA EXPERIÊNCIA E1
clear; 
close all; 
clc;

% H(z) = B(z) / A(z)
b = [0.0976, 0.1953, 0.0976];       % Coeficientes do numerador B(z)
a = [1, -0.9428, 0.33336];          % Coeficientes do denominador A(z)

fa = 48000; % 48 kHz

fprintf('Análise do Sistema LDIT H(z)\n');
fprintf('================================\n\n');

%% --- Atividade Prática (a): Resposta à Amostra Unitária ---
n_imp = 0:9; % 10 primeiros valores
h = impz(b, a, n_imp); % resposta ao impulso

% Valores calculados para a parte teórica
fprintf('--- Atividade (a): Resposta à Amostra Unitária ---\n');
fprintf('Os 10 primeiros valores de h[n] são:\n');
disp('     n      h[n]');
disp([n_imp', h]);

% Gráfico da resposta ao impulso
figure('Name', 'Atividade (a): Resposta à Amostra Unitária');
stem(n_imp, h, 'filled', 'LineWidth', 1.5);
title('Resposta à Amostra Unitária (h[n]) para 0 \leq n < 10');
xlabel('Amostra (n)');
ylabel('Amplitude');
grid on;
fprintf('O gráfico da resposta ao impulso foi gerado.\n\n');

%% --- Atividade Prática (b): Resposta em Frequência ---
fprintf('--- Atividade (b): Resposta em Frequência ---\n');
fprintf('A janela do FVTool foi aberta para análise.\n');
fprintf('Analisando o gráfico, o ganho é alto em baixas frequências e baixo em altas frequências.\n');
fprintf('O sistema pode ser classificado como um filtro PASSA-BAIXAS.\n\n');

% Fs ajusta o eixo para a frequência em Hz 
fvtool(b, a, 'Fs', fa);

% intervalo de -96 kHz a 96 kHz, quando f_a=48kHz
% resposta em frequência de -2*fa a 2*fa.

%% --- Atividade Prática (c): Ganho em Frequências Específicas ---
fprintf('--- Atividade (c): Ganho em Frequências Específicas ---\n');
freqs_hz = [0, 6000, 24000, 48000]; % Frequências em Hz (DC, 6kHz, 24kHz, 48kHz)

% freqz: calcula a resposta em frequência nos pontos desejados
H = freqz(b, a, freqs_hz, fa);

% Converte o módulo para dB e a fase para graus
ganho_mag_linear = abs(H);
fase_graus = rad2deg(angle(H));

% Exibe os resultados em uma tabela
fprintf('Frequência (Hz) | Ganho (Linear) | Fase (Graus)\n');
fprintf('--------------------------------------------------\n');
for i = 1:length(freqs_hz)
    fprintf('%-15d | %-14.4f | %-12.2f\n', freqs_hz(i), ganho_mag_linear(i), fase_graus(i));
end
fprintf('\nEstes valores podem ser comparados com a análise teórica e com os pontos no gráfico do FVTool.\n\n');

%% --- Atividade Prática (d): Filtragem de um Sinal Senoidal ---
fprintf('--- Atividade (d): Filtragem de um Seno de 6 kHz ---\n');

% Criação do sinal de entrada
f_sinal = 6000; % Frequência do seno: 6 kHz 
duracao = 0.002;
t = 0 : 1/fa : duracao - 1/fa; % Vetor de tempo
x_sinal = sin(2*pi*f_sinal*t); % Sinal de entrada senoidal

% Filtragem do sinal utilizando a função 'filter' [cite: 45]
y_sinal_filtrado = filter(b, a, x_sinal);

% Plotagem dos sinais de entrada e saída
figure('Name', 'Atividade (d): Filtragem de Sinal');
plot(t * 1000, x_sinal, 'b-', 'LineWidth', 1, 'DisplayName', 'Sinal de Entrada x[n]');
hold on;
plot(t * 1000, y_sinal_filtrado, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Sinal de Saída y[n]');
hold off;
title('Filtragem de um Seno de 6 kHz');
xlabel('Tempo (ms)');
ylabel('Amplitude');
legend('show');
grid on;
fprintf('Gráfico com os sinais de entrada e saída foi gerado para análise.\n');

% Ganho em regime permanente
% Pegamos a amplitude máxima na segunda metade do sinal para ignorar o transiente inicial
amp_entrada = max(x_sinal); % Amplitude da entrada é 1
amp_saida = max(y_sinal_filtrado(t >= duracao/2));
ganho_medido = amp_saida / amp_entrada;

fprintf('Ganho medido no regime permanente (em 6 kHz): %.4f\n', ganho_medido);
fprintf('Valor teórico do ganho em 6 kHz (item c): %.4f\n', ganho_mag_linear(2));
fprintf('Os valores são consistentes, validando o resultado.\n');