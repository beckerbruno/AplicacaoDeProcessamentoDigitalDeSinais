% Aplicacoes de Processamento Digital de Sinais - 4456S-04
% Experiência E4: Conversao A/D 
% Prof. Denis Fernandes 
% Ultima atualizacao: 27/03/2019

function []=FuncaoE4();

global ARec;
global h1 yh1 NSAMPLES;

while ARec.TotalSamples < NSAMPLES
end;
myRec = getaudiodata(ARec);

% atualiza oscilograma
yh1 = myRec(end-NSAMPLES+1:end);
refreshdata(h1);

% atualiza espectro
%************************************************************

%************************************************************

end





