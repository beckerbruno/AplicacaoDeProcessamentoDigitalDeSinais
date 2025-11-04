pip install opencv-python numpy
python water_meter_reader.py

Projeto de Leitura de Medidor de Água por Visão Computacional

Este projeto implementa um sistema de Visão Computacional em Python para extrair a leitura numérica de um medidor de água digital a partir de um vídeo. A técnica principal utilizada é o Template Matching para o reconhecimento dos dígitos em um display de 7 segmentos.

Requisitos

O projeto foi desenvolvido em Python e requer as seguintes bibliotecas:

•
opencv-python

•
numpy

•
pytesseract (e a instalação do Tesseract OCR no sistema)

Estrutura do Projeto

•
water_meter_reader.py: O script principal que contém a lógica de processamento de vídeo, pré-processamento de imagem, segmentação e Template Matching.

•
templates/: Diretório que armazena os templates de dígitos (0-9, ponto, hífen) usados para o Template Matching.

Como Funciona

1.
Extração de Frame: O script lê o vídeo e processa um frame por vez (ou um frame específico para o teste).

2.
Definição do ROI (Região de Interesse): Uma área específica do frame, correspondente ao display do medidor, é isolada.

3.
Pré-processamento: O ROI é convertido para escala de cinza, invertido e binarizado (limiarizado) para isolar os dígitos do fundo.

4.
Segmentação: O ROI processado é dividido em 8 partes iguais, correspondentes aos 8 caracteres do display.

5.
Template Matching: Cada segmento de dígito é comparado com um conjunto de templates pré-definidos (os arquivos .jpg na pasta templates/) usando o método cv2.TM_CCOEFF_NORMED. O dígito com a maior correlação é considerado o valor lido.

Uso

1.
Instalação de Dependências:

2.
Criação de Templates: O script water_meter_reader.py depende dos templates de dígitos. No desenvolvimento, os templates foram criados a partir do frame_0.jpg e renomeados manualmente. Para um uso mais robusto, todos os dígitos (0-9, ponto, hífen) devem ter seus templates na pasta templates/.

3.
Execução: Coloque o vídeo (video.mp4) no diretório /home/ubuntu/upload/.

Observações

•
A precisão do Template Matching depende da qualidade dos templates e da consistência da iluminação e do ângulo de visão no vídeo.

•
O Template Matching é uma solução de Visão Computacional, que é uma alternativa robusta ao OCR tradicional (Tesseract) para displays de 7 segmentos, onde o OCR puro pode falhar devido à natureza dos caracteres.

•
O código atual está configurado para ler o primeiro frame do vídeo. Para processar o vídeo inteiro, a lógica de loop deve ser implementada na função process_video.

•
O valor lido no teste foi 00??429-. Os caracteres ?? indicam que os templates para esses dígitos não foram criados ou o limiar de correlação precisa de ajuste. Para um projeto completo, todos os templates devem ser criados.

