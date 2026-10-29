#!/bin/bash
# Uso: ./buscar.sh "palabra o frase" carpeta

# Integrante 1: valida los argumentos y deja listas las variables
# "palabra" y "carpeta" (esta ultima con ruta completa).
validar_argumentos() {
  if [ $# -ne 2 ]; then
    echo "Uso: $0 \"palabra o frase\" carpeta" >&2
    exit 1
  fi

  if [ -z "$1" ]; then
    echo "Error: la palabra no puede estar vacia" >&2
    exit 1
  fi

  if [ ! -d "$2" ]; then
    echo "Error: '$2' no es una carpeta valida" >&2
    exit 1
  fi

  palabra="$1"
  carpeta="$(cd "$2" && pwd)"
}

# Integrante 2: $1=archivo $2=palabra. Imprime solo el numero de apariciones.
contar_apariciones() {
  local archivo="$1"
  local palabra="$2"
  local coincidencias

  # Omitir archivos inexistentes, ilegibles o una busqueda vacia.
  if [[ ! -f "$archivo" || ! -r "$archivo" || -z "$palabra" ]]; then
    printf '0\n'
    return 0
  fi

  # -I omite binarios; -o extrae cada coincidencia; -F busca texto literal.
  coincidencias=$(grep -I -o -F -- "$palabra" "$archivo" 2>/dev/null) \
    || coincidencias=''

  if [[ -z "$coincidencias" ]]; then
    printf '0\n'
  else
    printf '%s\n' "$coincidencias" | wc -l | tr -d '[:space:]'
    printf '\n'
  fi
}

# Integrante 3: $1=carpeta $2=palabra. Muestra "ruta: veces" si veces > 0.
recorrer_y_mostrar() {
  :
}

validar_argumentos "$@"
recorrer_y_mostrar "$carpeta" "$palabra"
