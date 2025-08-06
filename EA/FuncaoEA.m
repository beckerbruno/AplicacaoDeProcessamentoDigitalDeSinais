% Aplicações de Processamento Digital de Sinais - 4456S-04
% Experiência EA: Utilização do MATLAB em processamento de sinais: comandos básicos e programação
% Prof. Denis Fernandes 
% Ultima atualizacao: 22/02/2019
% Exemplo de um arquivo para criacao de uma funcao

% Cria uma funcao para calcular o fatorial de n

function[f] = FuncaoEA(n)

if n < 0,
    disp 'n deve ser positivo';
    return;
end;    
f = 1;
if n > 0,
    f = n*FuncaoEA(n-1);
end;

    

