% Aplicacoes de Processamento Digital de Sinais - 4456S-04
% Experincia E4: Conversao A/D 
% Prof. Denis Fernandes 
% Ultima atualizacao: 27/03/2019

function []=FuncaoE4()

% --- CORREÇÃO 1: Adicionar todas as globais necessárias ---
global ARec;
global h1 yh1 NSAMPLES h2 yh2;

% --- CORREÇÃO 2: Substituir o 'while' por um 'if' mais seguro ---
% O 'while' pode travar. Um 'if' garante que a função execute rápido.
% O TimerPeriod já garante que teremos amostras suficientes na maioria das vezes.
if ARec.TotalSamples < NSAMPLES
    return; % Sai da função se ainda não houver amostras suficientes
end
myRec = getaudiodata(ARec);

% atualiza oscilograma
yh1 = myRec(end-NSAMPLES+1:end);

% --- CORREÇÃO 3: Adicionar 'caller' para que a função encontre a variável yh1 ---
refreshdata(h1, 'caller');

% atualiza espectro
%************************************************************
% FFT do bloco de amostras
Y_fft = fft(yh1, NSAMPLES); 
% Magnitude do espectro
P2 = abs(Y_fft / NSAMPLES); 
% Primeira metade - de 0 a fa/2
P1 = P2(1:NSAMPLES/2);
% 2x compensa a energia da metade descartada
P1(2:end-1) = 2*P1(2:end-1); 

% Normaliza a magnitude, valor máximo unitário 
max_P1 = max(P1);

% --- CORREÇÃO 4: Adicionar verificação para evitar divisão por zero ---
if max_P1 > 0
    yh2 = P1 / max_P1;
else
    yh2 = P1; % Se o sinal for zero, não divide
end
%************************************************************
% Atualiza o gráfico do espectro
refreshdata(h2, 'caller');

end