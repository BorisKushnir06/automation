import requests
import json
import sys
import os
from datetime import datetime

# --- CONFIGURACIÓN ---
# NOTA: Reemplazar 'http://localhost:8000' con la URL real de tu servicio API.
BASE_URL = "https://api.frankfurter.app/"
DATA_DIR = "data"
LOG_FILE = "error.log"

def log_error(message):
    """Escribe un mensaje de error en el archivo de registro (error.log)."""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    log_entry = f"{timestamp} - ERROR: {message}\n"
    print(f"Error registrado en {LOG_FILE}: {message}")
    
    # Abrir el archivo de registro y escribir el mensaje
    with open(LOG_FILE, 'a') as f:
        f.write(log_entry)

def save_data(data, base_currency, target_currency, date_str):
    """Guarda los datos recibidos en formato JSON con un nombre de archivo específico."""
    
    # 1. Asegurar que el directorio 'data' exista
    if not os.path.exists(DATA_DIR):
        os.makedirs(DATA_DIR)

    # 2. Construir el nombre del archivo
    filename = f"{base_currency}_{target_currency}_{date_str}.json"
    filepath = os.path.join(DATA_DIR, filename)

    # 3. Guardar los datos en formato JSON
    try:
        with open(filepath, 'w') as f:
            json.dump(data, f, indent=4)
        print(f"\nDatos guardados exitosamente en: {filepath}")
    except Exception as e:
        error_msg = f"No se pudo guardar el archivo JSON '{filepath}': {e}"
        log_error(error_msg)


def get_exchange_rate(base_currency, target_currency, date_str):
    """Obtiene la tasa de cambio de la API."""
    
    # 1. Construir la URL de la API
    # Asume que la API usa parámetros de consulta como: /api/exchange-rate?base=USD&target=EUR&date=2025-01-01
    endpoint = (
        f"{BASE_URL}/{date_str}?from={base_currency}&to={target_currency}"
    )
    
    print(f"Solicitando datos a: {endpoint}")

    # 2. Realizar la solicitud HTTP
    try:
        response = requests.get(endpoint, timeout=10)
        response.raise_for_status()  # Lanza una excepción para códigos de estado HTTP 4xx/5xx

    except requests.exceptions.HTTPError as errh:
        error_msg = f"Error HTTP: {errh} (Código de estado: {response.status_code})"
        log_error(error_msg)
        return
    except requests.exceptions.ConnectionError as errc:
        error_msg = f"Error de Conexión: No se pudo conectar a {BASE_URL}. Asegúrate de que el servicio esté corriendo. Detalles: {errc}"
        log_error(error_msg)
        return
    except requests.exceptions.Timeout as errt:
        error_msg = f"Tiempo de espera agotado (Timeout) al conectar con la API: {errt}"
        log_error(error_msg)
        return
    except requests.exceptions.RequestException as err:
        error_msg = f"Error desconocido al realizar la solicitud: {err}"
        log_error(error_msg)
        return
    
    # 3. Procesar la respuesta JSON
    try:
        data = response.json()
        
        # Opcional: Verificar si la API devuelve un campo de error dentro del JSON (p. ej., para parámetros inválidos)
        if 'error' in data:
            error_msg = f"Error devuelto por la API para {date_str}: {data['error']}"
            log_error(error_msg)
            return

        print(f"Tasa de cambio recibida para {date_str}: {data.get(f"rates.{target_currency}", 'N/A')}")
        
        # 4. Guardar los datos
        save_data(data, base_currency, target_currency, date_str)

    except json.JSONDecodeError:
        error_msg = f"Error al decodificar la respuesta JSON de la API. Respuesta: {response.text[:100]}..."
        log_error(error_msg)
    except Exception as e:
        error_msg = f"Error inesperado al procesar la respuesta: {e}"
        log_error(error_msg)


if __name__ == "__main__":
    
    # Verificar el número de argumentos de la línea de comandos
    if len(sys.argv) != 4:
        print("Uso: python currency_exchange_rate.py <moneda_base> <moneda_objetivo> <fecha_AAAA-MM-DD>")
        print("Ejemplo: python currency_exchange_rate.py USD EUR 2025-05-15")
        log_error("Número incorrecto de argumentos proporcionados.")
        sys.exit(1)

    # Asignar argumentos
    base = sys.argv[1].upper()
    target = sys.argv[2].upper()
    date_str = sys.argv[3]

    # Validar formato de fecha simple
    try:
        datetime.strptime(date_str, "%Y-%m-%d")
    except ValueError:
        error_msg = f"Formato de fecha inválido: '{date_str}'. Use el formato AAAA-MM-DD."
        log_error(error_msg)
        sys.exit(1)
        
    get_exchange_rate(base, target, date_str)