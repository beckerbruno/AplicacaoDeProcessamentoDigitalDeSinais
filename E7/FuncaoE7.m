% Aplicacoes de Processamento Digital de Sinais - 4456S-04
% Experiência E7: Projeto e implementação de filtros FIR
% Prof. Denis Fernandes 
% Ultima atualizacao: 30/04/2019

function [y, zf] = FuncaoE7(x, b, zi)
% x - sinal a ser filtrado
% zi - condicoes iniciais do filtro
% zi - condicoes finais do filtro
% y - sinal filtrado

% Filtragem
%********************************************

[y zf] = filter(b,1,x,zi);

%********************************************

end





