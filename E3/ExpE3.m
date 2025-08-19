% Aplicacoes de Processamento Digital de Sinais - 4456S-04
% Experiência E3: Efeitos do comprimento finito da palavra 
% Prof. Denis Fernandes 
% Ultima atualizacao: 21/03/2019

clear; % limpa variáveis do workspace
clc; % limpa janela de comando

Fs = 48000; % frequencia de amostragem (Hz)
N = 8; % ordem do filtro
AP = 1; % atenuacao na banda de passagem (dB)
AS = 40; % atenuacao na banda de rejeicao (dB)
F = 15000; % frequencia de corte do filtro (Hz)

% projeto de um filtro digital elíptico
[b,a] = ellip(N,AP,AS,F/(Fs/2),'low'); % projeto da H(z) nao quantizada

% insira aqui a rotina para quantizacao dos coeficientes de H(z)
%**************************************************************
% coeficientes nao quantizados: a e b
% coeficientes quantizados: aq e bq
aq = a;
bq = b;
%**************************************************************

hd = dfilt.df2t(bq,aq); % filtro implementado em Forma Direta II transposta
fvtool(hd,'Fs',Fs);
