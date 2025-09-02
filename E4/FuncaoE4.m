% Aplicacoes de Processamento Digital de Sinais - 4456S-04
% Experi�ncia E4: Conversao A/D 
% Prof. Denis Fernandes 
% Ultima atualizacao: 27/03/2019

function []=FuncaoE4();

global ARec;
global h1 yh1 NSAMPLES h2 yh2;

while ARec.TotalSamples < NSAMPLES
end;
myRec = getaudiodata(ARec);

% atualiza oscilograma
yh1 = myRec(end-NSAMPLES+1:end);
refreshdata(h1);

% atualiza espectro
%************************************************************
% Calcula a FFT do bloco de amostras
Y_fft = fft(yh1, NSAMPLES); 
% Calcula a magnitude do espectro
P2 = abs(Y_fft / NSAMPLES); 
% Pega apenas a primeira metade do espectro (de 0 a fa/2)
P1 = P2(1:NSAMPLES/2);
% Multiplica por 2 para compensar a energia da metade descartada
P1(2:end-1) = 2*P1(2:end-1); 

% Normaliza a magnitude para que o valor máximo seja unitário 
max_P1 = max(P1);
if max_P1 > 0
	yh2 = P1 / max_P1;
else
	yh2 = P1; % Evita divisão por zero se o sinal for nulo
end
%************************************************************
% Atualiza o gráfico do espectro
refreshdata(h2, 'caller');

end





