#!/bin/bash
set -euo pipefail
cd -- "$(dirname -- "$0")"
datos=$(mktemp -d "${TMPDIR:-/tmp}/MANEJO_VERSIONES.XXXXXX")
datos=$(cd -- "$datos" && pwd -P)
trap 'rm -rf -- "$datos"' EXIT
mkdir -p "$datos/SUBCARPETA"
printf 'hola mundo\nhola hola\n' > "$datos/archivo1.txt"
printf 'hola mundo\n' > "$datos/SUBCARPETA/archivo 2.txt"
printf 'otro contenido\n' > "$datos/otro.txt"
printf 'hola\0hola\n' > "$datos/binario.dat"
printf '$ bash localizar.sh "hola" "%s"\n' "$datos"
bash localizar.sh hola "$datos"
