% Aplicacoes de Processamento Digital de Sinais - 4456S-04
% Experiência E5: Conversao D/A
% Prof. Denis Fernandes 
% Ultima atualizacao: 11/04/2019

close all; %fecha todas as figuras
clear; %limpa variáveis do workspace
clc; %limpa janela de comandos

% global ARec APly;

TT = 30.0; % tempo total de aquisicao em segundos

FA_AD = 48000; % frequencia de amostragem do A/D (tipicas 8000, 11025, 22050, 44100, 48000, and 96000)
FA_DA = 48000; % frequencia de amostragem do D/A (tipicas 8000, 11025, 22050, 44100, 48000, and 96000)
CH_AD = 1; % 1 mono, 2 estereo

NSAMPLES_AD = FA_AD/25; % bloco de amostras por aquisicao do A/D.
NSAMPLES_DA = FA_DA/25; % bloco de amostras para reproducao no D/A.

% plota oscilograma do sinal de entrada
subplot(221);
xh1=(0:NSAMPLES_AD-1)/(FA_AD*0.001);
yh1=xh1*0;
h1 = plot(xh1,yh1); hold off; grid on;
axis([[0 NSAMPLES_AD/10]/(FA_AD*0.001) -1.0 1.0]);
xlabel('Tempo (mseg.)'), ylabel('Amplitude (norm.)');
title('Audio In - Oscilograma');
set(h1,'YDataSource','yh1');
set(h1,'XDataSource','xh1');

% plota espectro do sinal de entrada
subplot(223);
yh2=abs(fft(yh1,length(yh1)));
yh2=yh2(1:length(yh2)/2);
yh2=yh2/max(yh2);
xh2=(0:(length(yh2)-1));
xh2=xh2*FA_AD/2/length(xh2);
h2 = plot(xh2,yh2); hold off; grid on;
axis([xh2(1) FA_AD/2 -0.1 1.1])
xlabel('Frequencia (Hz)'), ylabel('Magnitude (norm.)'),
title('Audio In - Espectro de Frequências');
set(h2,'YDataSource','yh2');
set(h2,'XDataSource','xh2');

% plota oscilograma do sinal de saida
subplot(222);
xh3=(0:NSAMPLES_DA-1)/(FA_DA*0.001);
yh3=xh3*0;
h3 = plot(xh3,yh3); hold off; grid on;
axis([[0 NSAMPLES_DA/10]/(FA_DA*0.001) -1.0 1.0]);
xlabel('Tempo (mseg.)'), ylabel('Amplitude (norm.)');
title('Audio Out - Oscilograma');
set(h3,'YDataSource','yh3');
set(h3,'XDataSource','xh3');

% plota espectro do sinal de saida
subplot(224);
yh4=abs(fft(yh3,length(yh3)));
yh4=yh4(1:length(yh4)/2);
yh4=yh4/max(yh4);
xh4=(0:(length(yh4)-1));
xh4=xh4*FA_DA/2/length(xh4);
h4 = plot(xh4,yh4); hold off; grid on;
axis([xh4(1) FA_DA/2 -0.1 1.1])
xlabel('Frequencia (Hz)'), ylabel('Magnitude (norm.)'),
title('Audio Out - Espectro de Frequências');
set(h4,'YDataSource','yh4');
set(h4,'XDataSource','xh4');

ARec = dsp.AudioRecorder('SampleRate',FA_AD, ... 
    'NumChannels',CH_AD, ...
    'BufferSizeSource','Property',...
    'BufferSize',NSAMPLES_AD, ... 
    'QueueDuration',0.25, ... 
    'SamplesPerFrame', NSAMPLES_AD);

APly = dsp.AudioPlayer('SampleRate',FA_DA, ...
    'BufferSizeSource','Property',...
    'BufferSize',NSAMPLES_DA, ... 
    'QueueDuration',0.25); 

tic;
fprintf('Start recording.\n');
while(toc < TT),
    % le dados do A/D
    yh1 = step(ARec); 
    
    % processa dados
    [yh3] = FuncaoE5(yh1);
        
    % escreve dados no D/A  
    step(APly, yh3);

    % atualiza oscilogramas
    refreshdata(h1);
    refreshdata(h3);

    % atualiza espectro entrada
    yh2=abs(fft(yh1,length(yh1)));
    yh2=yh2(1:length(yh2)/2);
    yh2=yh2/max(yh2);
    refreshdata(h2);

    % atualiza espectro saida
    yh4=abs(fft(yh3,length(yh3)));
    yh4=yh4(1:length(yh3)/2);
    yh4=yh4/max(yh4);
    refreshdata(h4);

    %forca atualizacao dos graficos
    drawnow;    
end;
fprintf('End recording.\n');

release(ARec); % fecha dispositivo de entrada de áudio
clear ARec % remove ARec do workspace
release(APly); % fecha dispositivo de saída de áudio
clear APly % remove APly do workspace


