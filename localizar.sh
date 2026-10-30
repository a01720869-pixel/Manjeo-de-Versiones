#!/bin/bash
# Uso: bash localizar.sh "palabra o frase" [carpeta]

if [[ $# -lt 1 || $# -gt 2 || -z "$1" ]]; then
    printf 'Uso: bash %s "palabra o frase" [carpeta]\n' "$0" >&2
    exit 1
fi

palabra="$1"
carpeta="${2-/}"

if [[ "$palabra" == *$'\n'* ]]; then
    printf 'Error: escribe el texto en una sola linea.\n' >&2
    exit 1
fi

if [[ ! -d "$carpeta" ]]; then
    printf 'Error: la carpeta no existe: %s\n' "$carpeta" >&2
    exit 1
fi

if ! carpeta=$(CDPATH= cd -- "$carpeta" && pwd -P); then
    printf 'Error: no se puede abrir la carpeta.\n' >&2
    exit 1
fi

# -I omite binarios, -l imprime solo rutas y -F busca texto literal.
# find recorre las subcarpetas y agrupa archivos, incluso con espacios.
# Se omiten errores de acceso a archivos o carpetas protegidas.
find "$carpeta" -type f -exec grep -I -l -F -- "$palabra" {} + 2>/dev/null

# Una busqueda sin coincidencias tambien es una ejecucion valida.
exit 0
