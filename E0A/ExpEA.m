% Aplicações de Processamento Digital de Sinais - 4456S-04
% Experiência EA: Utilização do MATLAB em processamento de sinais: comandos básicos e programação
% Prof. Denis Fernandes 
% Ultima atualizacao: 22/02/2019
% Exemplo de um arquivo de lista de comandos (M-File)

% Cria o sinal x[n]=(-1)^n*(u[n]-u[n-6]) com -10 <= n <= 10

n=-10:10;
x=zeros(1,length(n));
x=(-1).^n;
u=zeros(1,length(n));
u(11:15)=1;
x=x.*u;
disp(x); % apresenta os valores das amostras
stem(n,x); % apresenta o grafico do sinal
axis([min(n) max(n) 1.5*min(x) 1.5*max(x)]);
title('Sinal x[n]');
xlabel('amostra n');
ylabel('valor de x[n]');

