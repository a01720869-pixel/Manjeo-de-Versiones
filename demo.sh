#!/bin/bash
set -euo pipefail
cd -- "$(dirname -- "$0")"
datos=$(mktemp -d "${TMPDIR:-/tmp}/DEMO_BASH.XXXXXX")
datos=$(cd -- "$datos" && pwd -P)
trap 'rm -rf -- "$datos"' EXIT
mkdir -p "$datos/SUBCARPETA"
printf 'hola mundo\nhola hola\n' > "$datos/archivo1.txt"
printf 'otra linea\nhola mundo\n' > "$datos/SUBCARPETA/archivo 2.txt"
printf 'sin coincidencias\n' > "$datos/otro.txt"
printf 'hola\0hola\n' > "$datos/binario.dat"
printf '\nBUSQUEDA DE PALABRA\n$ bash buscar.sh "hola" "%s"\n' "$datos"
bash buscar.sh "hola" "$datos"
printf '\nBUSQUEDA DE FRASE\n$ bash buscar.sh "hola mundo" "%s"\n' "$datos"
bash buscar.sh "hola mundo" "$datos"
printf '\nPRUEBAS AUTOMATICAS\n'
bash pruebas.sh
