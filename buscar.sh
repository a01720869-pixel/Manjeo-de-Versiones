#!/bin/bash
# Uso: bash buscar.sh "palabra o frase" "/ruta/a/la/carpeta"

validar_argumentos() {
    if [[ $# -ne 2 ]]; then
        printf 'Uso: bash %s "palabra o frase" "carpeta"\n' "$0" >&2
        exit 1
    fi
    if [[ -z "$1" ]]; then
        printf 'Error: el texto de busqueda no puede estar vacio.\n' >&2
        exit 1
    fi
    if [[ "$1" == *$'\n'* ]]; then
        printf 'Error: la frase debe estar en una sola linea.\n' >&2
        exit 1
    fi
    if [[ ! -d "$2" ]]; then
        printf 'Error: no existe la carpeta: %s\n' "$2" >&2
        exit 1
    fi
    palabra="$1"
    if ! carpeta=$(CDPATH= cd -- "$2" && pwd -P); then
        printf 'Error: no se puede acceder a la carpeta.\n' >&2
        exit 1
    fi
}

contar_apariciones() {
    local archivo="$1" texto="$2" coincidencias
    if [[ ! -f "$archivo" || ! -r "$archivo" ]]; then
        printf '0\n'
        return 0
    fi
    # -I omite binarios; -F busca texto literal; -o separa coincidencias.
    if coincidencias=$(grep -I -F -o -- "$texto" "$archivo" 2>/dev/null); then
        printf '%s\n' "$coincidencias" | wc -l | tr -d '[:space:]'
        printf '\n'
    else
        printf '0\n'
    fi
}

recorrer_y_mostrar() {
    local directorio="$1" texto="$2" archivo veces lista estado=0
    # Guardar la lista permite detectar errores de find sin perderlos
    # en una sustitucion de proceso. NUL conserva rutas con espacios.
    lista=$(mktemp "${TMPDIR:-/tmp}/buscar-archivos.XXXXXX") || return 1
    if ! find "$directorio" -type f -print0 > "$lista"; then
        printf 'Error: no se pudo recorrer toda la carpeta.\n' >&2
        rm -f -- "$lista"
        return 1
    fi
    while IFS= read -r -d '' archivo; do
        veces=$(contar_apariciones "$archivo" "$texto")
        if [[ "$veces" -gt 0 ]]; then
            printf '%s: %s\n' "$archivo" "$veces" || { estado=1; break; }
        fi
    done < "$lista"
    rm -f -- "$lista"
    return "$estado"
}

validar_argumentos "$@"
recorrer_y_mostrar "$carpeta" "$palabra"
