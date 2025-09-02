clear;

global ARec;
global h1 yh1 FA_AD NSAMPLES;
global h2 yh2 f_axis;

TT = 30.0;
FA_AD = 16000;
BITS_AD = 16;
CH_AD = 1;
NSAMPLES = 512;

figure('Name', 'Analisador de Áudio em Tempo Real');
subplot(2, 1, 1);
xh1 = (0:NSAMPLES-1)/(FA_AD*0.001);
yh1 = zeros(1, NSAMPLES);
h1 = plot(xh1,yh1);
hold off; grid on;
axis([0 (NSAMPLES-1)/(FA_AD*0.001) -1.0 1.0]);
xlabel('Tempo (mseg.)'), ylabel('Amplitude (normalizada)');
title('Entrada de áudio - Oscilograma');
set(h1,'YDataSource','yh1');

subplot(2,1,2);
f_axis = (0:NSAMPLES/2-1) * FA_AD / NSAMPLES;
yh2 = zeros(1, NSAMPLES/2);
h2 = plot(f_axis, yh2);
hold off; grid on;
axis([0 FA_AD/2 0 1.1]);
xlabel('Frequência (Hz)'), ylabel('Magnitude Normalizada');
title('Espectro de Frequências');
set(h2,'YDataSource','yh2');

ARec = audiorecorder(FA_AD, BITS_AD, CH_AD);
ARec.TimerFcn = 'FuncaoE4';
ARec.TimerPeriod = NSAMPLES/FA_AD;
ARec.StartFcn = 'disp(''Iniciando gravação...'')';
ARec.StopFcn = 'disp(''Fim da gravação.'')';

record(ARec, TT);

uiwait(gcf);

stop(ARec);
delete(ARec);
clear ARec;