% =========================================================================
% Script para a Atividade Teórica (a) e (b)
% Projeto de Filtro IIR Rejeita-Banda (Butterworth + Bilinear)
% =========================================================================
clear; clc; close all;

grupo = 1;
fi  = 1.5e3;
fis = 1.8e3;
fss = 2.2e3;
fs  = 2.5e3;
fa  = 16e3;

% --- Requisitos de atenuação ---
ap = 1;      % Máxima atenuação na banda de passagem (dB) [cite: 102]
as = 20;     % Mínima atenuação na banda de rejeição (dB) [cite: 102]

fprintf('Projetando o filtro IIR. Grupo: %d\n\n', grupo);

% =========================================================================
% Roteiro de Projeto (7 Passos)
% =========================================================================

% --- Passo 1: Pré-distorcer as frequências (Transformação Bilinear) [cite: 105] ---
% Fórmula: W = 2*fa*tan(pi*f/fa)
W_i  = 2*fa*tan(pi*fi/fa);
W_is = 2*fa*tan(pi*fis/fa);
W_ss = 2*fa*tan(pi*fss/fa);
W_s  = 2*fa*tan(pi*fs/fa);

% --- Passo 2: Garantir a simetria do gabarito [cite: 106] ---
% O requisito é W_i * W_s = W_is * W_ss. Ajustamos uma das frequências
% da banda de rejeição se a condição não for satisfeita.
if abs(W_i*W_s - W_is*W_ss) > 1e-6 % Usa uma pequena tolerância
    fprintf('Ajustando simetria do gabarito...\n');
    W_ss = (W_i * W_s) / W_is; % Recalcula W_ss para forçar a simetria
end

% --- Passo 3: Transformar para especificações de um passa-baixas normalizado [cite: 107] ---
% Onde Wp_lp (banda de passagem) = 1 rad/s.
% Precisamos encontrar o Ws_lp (banda de rejeição) correspondente.
Bw = W_s - W_i; % Largura da banda de passagem
Ws_lp = abs( (W_is^2 - W_i*W_s) / (W_is * Bw) );

% --- Passo 4: Calcular a ordem (N) e a freq. de corte (W0) do Butterworth [cite: 108] ---
% Usamos a função 'buttord' do MATLAB para encontrar a menor ordem necessária
Wp_lp = 1; % A banda de passagem do protótipo é normalizada para 1 rad/s
[N, W0] = buttord(Wp_lp, Ws_lp, ap, as, 's'); % 's' indica projeto analógico
fprintf('Ordem do filtro calculada (N): %d\n', N);

% --- Passo 5: Determinar os coeficientes do filtro analógico passa-baixas [cite: 109] ---
% Usando a representação em Espaço de Estados (A,B,C,D) como sugerido [cite: 115]
[A,B,C,D] = butter(N, W0, 's');

% --- Passo 6: Transformar de passa-baixas para rejeita-banda analógico [cite: 113] ---
W0_centro = sqrt(W_i * W_s); % Frequência central do rejeita-banda
[Ar,Br,Cr,Dr] = lp2bs(A,B,C,D, W0_centro, Bw); % lp2bs: low-pass to band-stop

% --- Passo 7: Aplicar a transformação bilinear para obter o filtro digital [cite: 114] ---
[Ad,Bd,Cd,Dd] = bilinear(Ar,Br,Cr,Dr, fa);

% Converte de Espaço de Estados para Coeficientes de Função de Transferência (b,a)
[b,a] = ss2tf(Ad,Bd,Cd,Dd);

fprintf('Coeficientes do filtro (b, a) calculados com sucesso.\n');
fprintf('O vetores "b" e "a" foram criados no seu workspace.\n\n');

% --- Atividade Teórica (b): Plotar a resposta em frequência  ---
fprintf('Abrindo a Ferramenta de Análise de Filtros (fvtool)...\n');
fvtool(b, a, 'Fs', fa);