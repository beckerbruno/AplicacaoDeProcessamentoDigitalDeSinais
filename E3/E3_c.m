% Experiência E3: Efeitos do comprimento finito da palavra 
% MODIFICADO para o item (c) da Atividade Prática

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

% --- Conversão para SOS ANTES da quantização  ---
sos_original = tf2sos(b, a);
hd_sos_original = dfilt.df2tsos(sos_original); % Filtro SOS original

% --- Vetor com os bits para quantização ---
bits_vetor = [32, 16, 8];
filtros_sos_quantizados = {hd_sos_original};
legendas = {'Original SOS'};

% --- Loop para quantizar e analisar para cada número de bits ---
for i = 1:length(bits_vetor)
    n_bits = bits_vetor(i);
    
    % Quantização da matriz SOS
    escala = 2^(n_bits - 1);
    sos_q = round(sos_original * escala) / escala;

    % Cria o objeto de filtro SOS quantizado
    hd_sos_q = dfilt.df2tsos(sos_q);
    filtros_sos_quantizados{end+1} = hd_sos_q;
    legendas{end+1} = ['SOS Quantizado ' num2str(n_bits) ' bits'];
    
    % Verificação de estabilidade (para SOS, todas as seções devem ser estáveis)
    disp(['--- Análise para Quantização de ' num2str(n_bits) ' bits (Forma SOS) ---']);
    estavel = true;
    for secao = 1:size(sos_q, 1)
        polos_secao = roots(sos_q(secao, 4:6)); % Polos da seção atual
        if any(abs(polos_secao) >= 1)
            estavel = false;
            break;
        end
    end
    
    if estavel
        disp('O filtro SOS quantizado É ESTÁVEL.');
    else
        disp('O filtro SOS quantizado É INSTÁVEL.');
    end
    disp(' ');
end

% --- Ferramenta de visualização para comparar todos os filtros SOS ---
h_fv = fvtool(filtros_sos_quantizados{:}, 'Fs', Fs);
legend(h_fv, legendas{:});