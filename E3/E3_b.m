% Experiência E3: Efeitos do comprimento finito da palavra 
% MODIFICADO para o item (b) da Atividade Prática

clear; 
clc; 
close all;

% --- Parâmetros e Projeto do Filtro Original ---
Fs = 48000; 
N = 8; 
AP = 1; 
AS = 40; 
F = 15000; 
[b,a] = ellip(N,AP,AS,F/(Fs/2),'low');
hd_original = dfilt.df2t(b,a); % Filtro original não quantizado

% --- Vetor com os bits para quantização ---
bits_vetor = [32, 16, 8];
filtros_quantizados = {hd_original}; % Inicia a lista de filtros com o original
legendas = {'Original (não quantizado)'};

% --- Loop para quantizar e analisar para cada número de bits ---
for i = 1:length(bits_vetor)
    n_bits = bits_vetor(i);
    
    % Rotina para quantizacao dos coeficientes 
    % Simula um quantizador de ponto fixo.
    % Os coeficientes são multiplicados por 2^(n_bits-1), arredondados
    % para o inteiro mais próximo, e depois a escala é removida.
    escala = 2^(n_bits - 1);
    bq = round(b * escala) / escala;
    aq = round(a * escala) / escala;
    
    % Cria o objeto de filtro quantizado
    hd_q = dfilt.df2t(bq,aq);
    filtros_quantizados{end+1} = hd_q; % Adiciona o filtro à lista
    legendas{end+1} = ['Quantizado ' num2str(n_bits) ' bits'];
    
    % Verificação de estabilidade do filtro quantizado 
    disp(['--- Análise para Quantização de ' num2str(n_bits) ' bits (Forma Direta) ---']);
    polos_q = roots(aq);
    max_polo_q = max(abs(polos_q));
    disp(['Módulo do maior polo quantizado: ', num2str(max_polo_q)]);
    if max_polo_q < 1
        disp('O filtro quantizado É ESTÁVEL.');
    else
        disp('O filtro quantizado É INSTÁVEL.');
    end
    disp(' ');
end

% --- Ferramenta de visualização para comparar todos os filtros ---
h_fv = fvtool(filtros_quantizados{:}, 'Fs', Fs);
legend(h_fv, legendas{:});