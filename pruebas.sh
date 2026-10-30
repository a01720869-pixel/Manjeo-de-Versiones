#!/bin/bash
set -euo pipefail
cd -- "$(dirname -- "$0")"
datos=$(mktemp -d "${TMPDIR:-/tmp}/PRUEBAS_VERSIONES.XXXXXX")
datos=$(cd -- "$datos" && pwd -P)
trap 'chmod -R u+rwX "$datos"; rm -rf -- "$datos"' EXIT
mkdir -p "$datos/DATOS/SUBCARPETA" "$datos/VACIA"
printf 'hola mundo\nhola hola\n' > "$datos/DATOS/archivo1.txt"
printf 'hola mundo\n' > "$datos/DATOS/SUBCARPETA/archivo 2.txt"
printf 'hola\0hola\n' > "$datos/DATOS/binario.dat"
printf 'hola\n' > "$datos/DATOS/ilegible.txt"
chmod 000 "$datos/DATOS/ilegible.txt"
printf 'otro contenido\n' > "$datos/DATOS/otro.txt"
printf '%s\n%s\n' "$datos/DATOS/archivo1.txt" "$datos/DATOS/SUBCARPETA/archivo 2.txt" | LC_ALL=C sort > "$datos/esperado"
for texto in hola 'hola mundo'; do
    bash buscar.sh "$texto" "$datos/DATOS" | LC_ALL=C sort > "$datos/real"
    diff -u "$datos/esperado" "$datos/real"
done
[[ -z "$(bash buscar.sh ausente "$datos/DATOS")" ]]
[[ -z "$(bash buscar.sh hola "$datos/VACIA")" ]]
mkdir "$datos/LITERAL"
printf 'a.b -hola\n' > "$datos/LITERAL/archivo.txt"
printf 'axb\n' > "$datos/LITERAL/otro.txt"
[[ "$(bash buscar.sh a.b "$datos/LITERAL")" == "$datos/LITERAL/archivo.txt" ]]
[[ "$(bash buscar.sh -hola "$datos/LITERAL")" == "$datos/LITERAL/archivo.txt" ]]
comprobar_error() {
    local estado=0
    bash buscar.sh "$@" > "$datos/salida" 2> "$datos/error" || estado=$?
    [[ "$estado" == 1 && -s "$datos/error" && ! -s "$datos/salida" ]]
}
comprobar_error
comprobar_error ''
comprobar_error hola ''
comprobar_error hola "$datos/NO_EXISTE"
comprobar_error hola "$datos/DATOS" extra
comprobar_error $'hola\nmundo'
# Comprobar la ruta predeterminada sin escanear todos los archivos del Mac.
mkdir "$datos/BIN"
cat > "$datos/BIN/find" <<'FIN'
#!/bin/bash
printf '%s\n' "$1" > "$RUTA_PRUEBA"
FIN
chmod +x "$datos/BIN/find"
RUTA_PRUEBA="$datos/raiz" PATH="$datos/BIN:$PATH" bash buscar.sh hola
[[ "$(cat "$datos/raiz")" == / ]]
printf 'Todas las pruebas pasaron: palabra, frase, rutas, binarios, ilegibles, errores y carpeta opcional.\n'
