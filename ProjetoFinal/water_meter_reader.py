import cv2
import numpy as np
import os
import glob

# --- Funções de Processamento de Imagem e Visão Computacional ---

def preprocess_display_roi(roi):
    """
    Aplica pré-processamento para isolar os dígitos do display LCD.
    
    Args:
        roi (np.array): Região de Interesse (tela LCD).
        
    Returns:
        np.array: Imagem binária com os dígitos isolados.
    """
    # 1. Escala de Cinza
    gray = cv2.cvtColor(roi, cv2.COLOR_BGR2GRAY)
    
    # 2. Inversão (dígitos escuros em fundo claro -> dígitos claros em fundo escuro)
    inverted = cv2.bitwise_not(gray)
    
    # 3. Limiarização (ajustar o valor de limiar conforme a iluminação)
    # O valor 100 funcionou razoavelmente no teste anterior.
    _, thresh = cv2.threshold(inverted, 100, 255, cv2.THRESH_BINARY)
    
    return thresh

def segment_digits(processed_image):
    """
    Segmenta a imagem processada em 8 ROIs de largura igual.
    
    Args:
        processed_image (np.array): Imagem binária processada.
        
    Returns:
        list: Lista de imagens (np.array) de dígitos individuais.
    """
    h, w = processed_image.shape
    num_digits = 8 # 7 dígitos + 1 caractere extra (ponto/hífen)
    digit_width = w // num_digits
    
    digits = []
    for i in range(num_digits):
        x_start = i * digit_width
        x_end = (i + 1) * digit_width
        # Ajuste fino para o último caractere, que pode ser menor
        if i == num_digits - 1:
            x_end = w # Garante que o último caractere seja incluído
            
        digit_roi = processed_image[:, x_start:x_end]
        digits.append(digit_roi)
        
    return digits

def load_templates(template_dir="./templates"):
    """
    Carrega os templates de dígitos.
    
    Returns:
        dict: Dicionário onde a chave é o valor do dígito e o valor é a imagem do template.
    """
    templates = {}
    for filepath in glob.glob(os.path.join(template_dir, "*.jpg")):
        filename = os.path.basename(filepath)
        # O nome do arquivo é o valor do dígito (ex: "4.jpg" -> "4")
        # Exceção para o hífen: "minus.jpg" -> "-"
        digit_value = filename.split('.')[0]
        if digit_value.startswith('0_'):
            digit_value = '0'
        elif digit_value == 'minus':
            digit_value = '-'
            
        template = cv2.imread(filepath, cv2.IMREAD_GRAYSCALE)
        # O template deve ser binário (preto e branco)
        _, template_thresh = cv2.threshold(template, 100, 255, cv2.THRESH_BINARY)
        
        templates[digit_value] = template_thresh
        
    return templates

def classify_digit_template_matching(digit_image, templates):
    """
    Classifica um dígito usando Template Matching.
    
    Args:
        digit_image (np.array): Imagem binária de um único dígito.
        templates (dict): Dicionário de templates.
        
    Returns:
        str: O dígito reconhecido.
    """
    best_match = '?'
    max_corr = -1
    
    for value, template in templates.items():
        # Redimensionar o template para a altura do dígito e manter a proporção.
        h_d, w_d = digit_image.shape
        h_t, w_t = template.shape
        
        # Redimensionar o template para o tamanho do dígito
        template_resized = cv2.resize(template, (w_d, h_d), interpolation=cv2.INTER_AREA)
        
        # Template Matching (TM_CCOEFF_NORMED é o mais robusto)
        result = cv2.matchTemplate(digit_image, template_resized, cv2.TM_CCOEFF_NORMED)
        _, max_val, _, _ = cv2.minMaxLoc(result)
        
        if max_val > max_corr:
            max_corr = max_val
            best_match = value
            
    # Um limiar de correlação para aceitar o resultado
    if max_corr > 0.7: # 0.7 é um chute, pode precisar de ajuste
        return best_match
    else:
        return '?'

def read_meter_value(frame, templates):
    """
    Localiza o display do medidor no frame e extrai o valor.
    
    Args:
        frame (np.array): O frame do vídeo.
        templates (dict): Dicionário de templates.
        
    Returns:
        str: O valor lido do medidor.
    """
    h, w, _ = frame.shape
    
    # Coordenadas do ROI (ajustadas para a tela LCD)
    # x_start: 800, x_end: 1100
    # y_start: 520, y_end: 580
    x_start = int(w * 0.416) # 800/1920
    x_end = int(w * 0.572)   # 1100/1920
    y_start = int(h * 0.481) # 520/1080
    y_end = int(h * 0.537)   # 580/1080
    
    roi = frame[y_start:y_end, x_start:x_end]
    
    # 1. Pré-processamento
    processed_roi = preprocess_display_roi(roi)
    
    # 2. Segmentação
    digits_images = segment_digits(processed_roi)
    
    # 3. Classificação
    meter_value = ""
    for i, digit_img in enumerate(digits_images):
        digit = classify_digit_template_matching(digit_img, templates)
        meter_value += digit
        
    return meter_value

# --- Função Principal de Processamento de Vídeo ---

def process_video(video_path, output_dir="./frames"):
    """
    Processa o vídeo, extrai frames e tenta ler o valor do medidor.
    
    Args:
        video_path (str): Caminho para o arquivo de vídeo.
        output_dir (str): Diretório para salvar frames e imagens de debug.
    """
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
        
    cap = cv2.VideoCapture(video_path)
    if not cap.isOpened():
        print(f"Erro ao abrir o vídeo: {video_path}")
        return

    # Carregar templates
    templates = load_templates()
    if not templates:
        print("Erro: Nenhum template de dígito encontrado. Certifique-se de que os templates foram criados e nomeados corretamente.")
        return

    # Processar apenas um frame para o teste inicial (o primeiro)
    frame_number = 0
    cap.set(cv2.CAP_PROP_POS_FRAMES, frame_number)
    ret, frame = cap.read()

    if ret:
        print(f"Processando frame {frame_number}...")
        meter_value = read_meter_value(frame, templates)
        print(f"Valor lido do medidor no frame {frame_number}: {meter_value}")
    else:
        print(f"Não foi possível ler o frame {frame_number}.")

    cap.release()

if __name__ == "__main__":
    video_file = "./video.mp4"
    process_video(video_file)
