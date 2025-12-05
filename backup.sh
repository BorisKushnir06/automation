#!/bin/bash

# Nombre del Script: backup.sh
# Descripción: Crea una copia de seguridad comprimida (.tar.gz) de un directorio especificado.
# Uso: ./backup.sh <directorio_origen> [directorio_destino]

# --- Configuración ---
DEFAULT_DESTINATION="/backup"

# --- Análisis y Validación de Argumentos ---

# Comprobar si se proporciona al menos un argumento (directorio de origen)
if [ -z "$1" ]; then
    echo "Error: Falta la ruta al directorio de origen." >&2
    echo "Uso: $0 <directorio_origen> [directorio_destino]" >&2
    exit 1
fi

SOURCE_DIR="$1"
DESTINATION_DIR="${2:-$DEFAULT_DESTINATION}" # Usar el segundo argumento o el valor predeterminado /backup

# 1. Comprobar si SOURCE_DIR existe y es un directorio
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: El directorio de origen '$SOURCE_DIR' no existe o no es un directorio." >&2
    exit 1
fi

# 2. Comprobar si DESTINATION_DIR existe. Si no, intentar crearlo.
if [ ! -d "$DESTINATION_DIR" ]; then
    echo "No se encontró el directorio de destino '$DESTINATION_DIR'. Intentando crearlo..."
    mkdir -p "$DESTINATION_DIR"
    if [ $? -ne 0 ]; then
        echo "Error: Falló la creación del directorio de destino '$DESTINATION_DIR'. Compruebe los permisos." >&2
        exit 1
    fi
fi

# Eliminar la barra diagonal final de SOURCE_DIR para un nombre de archivo más limpio
DIR_NAME=$(basename "$SOURCE_DIR")

# --- Ejecución de la Copia de Seguridad ---

# Obtener la fecha y hora actual en un formato adecuado para el nombre del archivo
DATE_TIME=$(date +%Y%m%d_%H%M%S)

# Construir la ruta completa y el nombre del archivo para el archivo
BACKUP_FILENAME="${DIR_NAME}_${DATE_TIME}.tar.gz"
BACKUP_PATH="${DESTINATION_DIR}/${BACKUP_FILENAME}"

echo "Iniciando la copia de seguridad de '$SOURCE_DIR' a '$BACKUP_PATH'..."

# Crear el archivo tar comprimido (c: create, z: gzip, v: verbose, f: file)
# La opción '-C' cambia el directorio antes de procesar, asegurando que el contenido del archivo
# comience desde el nombre del directorio en sí, no desde la ruta completa.
tar -czf "$BACKUP_PATH" -C "$(dirname "$SOURCE_DIR")" "$DIR_NAME"

# Comprobar el estado de salida del comando tar
if [ $? -eq 0 ]; then
    echo "--- ¡Copia de seguridad exitosa! ---"
    echo "Archivo guardado en: $BACKUP_PATH"
else
    echo "Error: La copia de seguridad falló. El comando 'tar' devolvió un error." >&2
    exit 1
fi

exit 0#!/bin/bash

# Nombre del Script: backup.sh
# Descripción: Crea una copia de seguridad comprimida (.tar.gz) de un directorio especificado.
# Uso: ./backup.sh <directorio_origen> [directorio_destino]

# --- Configuración ---
DEFAULT_DESTINATION="/backup"

# --- Análisis y Validación de Argumentos ---

# Comprobar si se proporciona al menos un argumento (directorio de origen)
if [ -z "$1" ]; then
    echo "Error: Falta la ruta al directorio de origen." >&2
    echo "Uso: $0 <directorio_origen> [directorio_destino]" >&2
    exit 1
fi

SOURCE_DIR="$1"
DESTINATION_DIR="${2:-$DEFAULT_DESTINATION}" # Usar el segundo argumento o el valor predeterminado /backup

# 1. Comprobar si SOURCE_DIR existe y es un directorio
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: El directorio de origen '$SOURCE_DIR' no existe o no es un directorio." >&2
    exit 1
fi

# 2. Comprobar si DESTINATION_DIR existe. Si no, intentar crearlo.
if [ ! -d "$DESTINATION_DIR" ]; then
    echo "No se encontró el directorio de destino '$DESTINATION_DIR'. Intentando crearlo..."
    mkdir -p "$DESTINATION_DIR"
    if [ $? -ne 0 ]; then
        echo "Error: Falló la creación del directorio de destino '$DESTINATION_DIR'. Compruebe los permisos." >&2
        exit 1
    fi
fi

# Eliminar la barra diagonal final de SOURCE_DIR para un nombre de archivo más limpio
DIR_NAME=$(basename "$SOURCE_DIR")

# --- Ejecución de la Copia de Seguridad ---

# Obtener la fecha y hora actual en un formato adecuado para el nombre del archivo
DATE_TIME=$(date +%Y%m%d_%H%M%S)

# Construir la ruta completa y el nombre del archivo para el archivo
BACKUP_FILENAME="${DIR_NAME}_${DATE_TIME}.tar.gz"
BACKUP_PATH="${DESTINATION_DIR}/${BACKUP_FILENAME}"

echo "Iniciando la copia de seguridad de '$SOURCE_DIR' a '$BACKUP_PATH'..."

# Crear el archivo tar comprimido (c: create, z: gzip, v: verbose, f: file)
# La opción '-C' cambia el directorio antes de procesar, asegurando que el contenido del archivo
# comience desde el nombre del directorio en sí, no desde la ruta completa.
tar -czf "$BACKUP_PATH" -C "$(dirname "$SOURCE_DIR")" "$DIR_NAME"

# Comprobar el estado de salida del comando tar
if [ $? -eq 0 ]; then
    echo "--- ¡Copia de seguridad exitosa! ---"
    echo "Archivo guardado en: $BACKUP_PATH"
else
    echo "Error: La copia de seguridad falló. El comando 'tar' devolvió un error." >&2
    exit 1
fi

exit 0
