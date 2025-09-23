% Aplicacoes de Processamento Digital de Sinais - 4456S-04
% Experiência E6: Conversão de taxas de amostragem
% ARQUIVO DE FUNÇÃO MODIFICADO

function [y, zf] = FuncaoE6(x, fa_AD, fa_DA, zi)
% x - sinal a ser filtrado com taxa fa_AD
% fa_AD - frequencia de amostragem do A/D
% fa_DA - frequencia de amostragem do D/A
% zi - condicoes iniciais para o filtro
% y - sinal filtrado com taxa fa_DA
% zf - condições finais do filtro para a próxima iteração

% A variável 'b' para os coeficientes do filtro é declarada como 'persistent'.
% Isso significa que ela só será calculada na primeira vez que a função for
% chamada, evitando o reprojeto do filtro a cada bloco de áudio,
% o que torna o processo muito mais eficiente.
persistent b;

% Conversao de taxas de amostragem
% ********************************************

% 1. CÁLCULO DOS PARÂMETROS L, M e FREQUÊNCIA DE CORTE (fc)
% Este cálculo é feito uma vez, junto com o projeto do filtro.
if isempty(b)
    fprintf('Configurando o conversor de taxa de amostragem...\n');
    mdc = gcd(fa_AD, fa_DA);
    L = fa_DA / mdc;
    M = fa_AD / mdc;
    fc = min(fa_AD, fa_DA) / 2;
    
    % A frequência de corte para a função fir1 deve ser normalizada
    % pela frequência de amostragem INTERMEDIÁRIA (após o upsampling).
    fa_intermediaria = fa_AD * L;
    Wn = fc / (fa_intermediaria / 2);
    
    % PROJETO DO FILTRO PASSA-BAIXAS (FPB)
    % Usamos fir1 para projetar o filtro FIR [cite: 100]
    ordem_filtro = 90; % Ordem sugerida no enunciado [cite: 101]
    
    % O ganho L é aplicado diretamente nos coeficientes do filtro 
    b = L * fir1(ordem_filtro, Wn, 'low');
    
    fprintf('Conversor configurado para: L=%d, M=%d, fc=%.0f Hz\n', L, M, fc);
end

% 2. PROCESSO DE CONVERSÃO DE TAXA
% 2.1 - Interpolação (Upsampling): Aumenta a taxa de amostragem por um fator L
% inserindo L-1 zeros entre cada amostra de 'x'.
x_up = upsample(x, L);

% 2.2 - Filtragem Passa-Baixas: Remove as imagens espectrais criadas pelo
% upsampling e evita o aliasing do downsampling. A função 'filter' usa
% as condições iniciais 'zi' e retorna as condições finais 'zf'. [cite: 100]
[y_filtrado, zf] = filter(b, 1, x_up, zi);

% 2.3 - Dizimação (Downsampling): Reduz a taxa de amostragem por um fator M
% mantendo apenas uma amostra a cada M amostras.
y = downsample(y_filtrado, M);

% ********************************************

end