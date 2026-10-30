
#!/bin/bash

# Integrante 3: Recorrer archivos y mostrar resultados

recorrer_y_mostrar() {
    local carpeta="$1"
    local palabra="$2"
    local archivo
    local cantidad
    local encontrados=0

    # Recorrer archivos y subcarpetas
    while IFS= read -r -d '' archivo; do

        # Llamar la funcion del integrante 2
        cantidad=$(contar_apariciones "$archivo" "$palabra")

        # Mostrar solo archivos con coincidencias
        if (( cantidad > 0 )); then
            echo "$archivo: $cantidad"
            ((encontrados++))
        fi

    done < <(find "$carpeta" -type f -print0)

    # Mensaje si no se encontro la palabra
    if (( encontrados == 0 )); then
        echo "No se encontraron coincidencias."
    fi
}
