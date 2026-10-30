#!/bin/bash
set -euo pipefail
cd -- "$(dirname -- "$0")"
datos=$(mktemp -d "${TMPDIR:-/tmp}/PRUEBAS_BASH.XXXXXX")
datos=$(cd -- "$datos" && pwd -P)
trap 'chmod -R u+rwX "$datos"; rm -rf -- "$datos"' EXIT
mkdir -p "$datos/DATOS/SUBCARPETA" "$datos/VACIA"
printf 'hola mundo\nhola hola\n' > "$datos/DATOS/archivo1.txt"
printf 'hola mundo\n' > "$datos/DATOS/SUBCARPETA/archivo 2.txt"
printf 'hola\0hola\n' > "$datos/DATOS/binario.dat"
printf 'hola\n' > "$datos/DATOS/ilegible.txt"
chmod 000 "$datos/DATOS/ilegible.txt"
printf 'sin coincidencias\n' > "$datos/DATOS/otro.txt"
bash buscar.sh hola "$datos/DATOS" | LC_ALL=C sort > "$datos/real"
printf '%s: 3\n%s: 1\n' "$datos/DATOS/archivo1.txt" "$datos/DATOS/SUBCARPETA/archivo 2.txt" | LC_ALL=C sort > "$datos/esperado"
diff -u "$datos/esperado" "$datos/real"
printf 'OK: palabra, subcarpeta, espacios, binarios e ilegibles.\n'
bash buscar.sh 'hola mundo' "$datos/DATOS" | LC_ALL=C sort > "$datos/real"
printf '%s: 1\n%s: 1\n' "$datos/DATOS/archivo1.txt" "$datos/DATOS/SUBCARPETA/archivo 2.txt" | LC_ALL=C sort > "$datos/esperado"
diff -u "$datos/esperado" "$datos/real"
printf 'OK: frase completa.\n'
[[ -z "$(bash buscar.sh ausente "$datos/DATOS")" ]]
[[ -z "$(bash buscar.sh hola "$datos/VACIA")" ]]
printf 'OK: sin coincidencias y carpeta vacia.\n'
mkdir "$datos/LITERALES"
printf 'a.b axb a.b -hola\n' > "$datos/LITERALES/texto.txt"
[[ "$(bash buscar.sh a.b "$datos/LITERALES")" == "$datos/LITERALES/texto.txt: 2" ]]
[[ "$(bash buscar.sh -hola "$datos/LITERALES")" == "$datos/LITERALES/texto.txt: 1" ]]
printf 'OK: puntos literales y texto que empieza con guion.\n'
comprobar_error() {
    local estado=0
    bash buscar.sh "$@" > "$datos/salida" 2> "$datos/error" || estado=$?
    [[ "$estado" == 1 && -s "$datos/error" && ! -s "$datos/salida" ]]
}
comprobar_error
comprobar_error hola
comprobar_error hola "$datos/DATOS" extra
comprobar_error '' "$datos/DATOS"
comprobar_error hola "$datos/NO_EXISTE"
comprobar_error $'hola\nmundo' "$datos/DATOS"
printf 'OK: validacion de argumentos.\nTodas las pruebas pasaron.\n'
