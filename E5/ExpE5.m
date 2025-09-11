function [y] = FuncaoE5(x)
% Item c) Modulação em Amplitude (AM)
    
    % --- Escolha os parâmetros do seu grupo aqui (Tabela do PDF) ---
    % Exemplo para o Grupo 1:
    fc = 18000; [span_0](start_span)% Frequência da portadora (Hz)[span_0](end_span)
    fa = 48000; [span_1](start_span)% Frequência de amostragem (Hz)[span_1](end_span)
    % A frequência fm é a do sinal de entrada 'x'
    
    % A variável 'n' é persistente. Seu valor é guardado entre as chamadas da função
    % para garantir a continuidade da fase da portadora.
    persistent n;
    
    % Inicializa 'n' em 0 na primeira vez que a função é executada
    if isempty(n)
        n = 0;
    end

    % Determina o número de amostras no bloco de entrada atual
    blockSize = length(x);
    
    % Cria o vetor de tempo para o bloco ATUAL, continuando de onde parou
    t = (n : n + blockSize - 1)' / fa;
    
    % Gera a portadora para este bloco de tempo
    carrier = cos(2 * pi * fc * t);
    
    % O sinal modulante é o sinal de entrada 'x'.
    % A fórmula [0.5 + 0.25*cos(Ωm*n)] se torna (0.5 + 0.25*x)
    % Usamos '.*' para multiplicação elemento a elemento
    y = (0.5 + 0.25 * x) .* carrier;
    
    % Atualiza o contador de amostras para a próxima chamada da função
    n = n + blockSize;

end
