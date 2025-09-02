% Aplicacoes de Processamento Digital de Sinais - 4456S-04
% Experi�ncia E4: Conversao A/D 
% Prof. Denis Fernandes 
% Ultima atualizacao: 27/03/2019

clear; % limpa vari�veis do workspace

global ARec;
global h1 yh1 NSAMPLES FA_AD;
global h2 yh2 f_axis;

TT = 30.0;      % tempo total de aquisicao em segundos
FA_AD = 16000;   % frequencia de amostragem do A/D (tipicas 8000, 11025, 22050, 44100, 48000, and 96000)
BITS_AD = 16;   % numero de bits por amostra do A/D (8, 16 ou 24)
CH_AD = 1;      % 1 mono, 2 estereo
NSAMPLES = 512; % bloco de amostras por aquisicao.

% plota oscilograma
figure('Name', 'Áudio em Tempo Real');
subplot(2, 1, 1);
xh1 = (0:NSAMPLES-1)/(FA_AD*0.001);
yh1 = xh1*0;
h1 = plot(xh1,yh1); hold off; grid on;
axis([[0 NSAMPLES-1]/(FA_AD*0.001) -1.0 1.0]);
xlabel('Tempo (mseg.)'), ylabel('Amplitude (normalizada)');
title('Entrada de audio - Oscilograma');
set(h1,'YDataSource','yh1');
set(h1,'XDataSource','xh1');

% plota espectro do sinal
%************************************************************
subplot(2,1,2);
% O eixo da frequência vai de 0 a FA_AD/2 (Nyquist)
f_axis = (0:NSAMPLES/2-1) * FA_AD / NSAMPLES; 
yh2 = zeros(1, NSAMPLES/2); % Amplitude do espectro
h2 = plot(f_axis, yh2); 
hold off; grid on;
axis([0 FA_AD/2 0 1.1]); % Eixo Y normalizado até 1.1 para margem
xlabel('Frequência (Hz)'), ylabel('Magnitude Normalizada');
title('Espectro de Frequências');
% Liga as fontes de dados para atualização em tempo real
set(h2,'YDataSource','yh2');

%************************************************************

ARec = audiorecorder(FA_AD, BITS_AD, CH_AD); % cria objeto para grava��o de audio
ARec.TimerFcn = 'FuncaoE4';
ARec.TimerPeriod = NSAMPLES/FA_AD;
ARec.StartFcn = 'disp(''Start recording.'')';
ARec.StopFcn = 'disp(''End recording.'')';
recordblocking(ARec, NSAMPLES*ceil(TT*FA_AD/NSAMPLES)/FA_AD);

delete(ARec) % remove o objeto ARec
clear ARec   % remove ai do workspace



