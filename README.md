# Buscador de palabras y frases en Bash

Actividad: IA y bash shell. Actualización del repositorio Manjeo-de-Versiones en la rama `actividad-bash-completa`.

## Objetivo

Buscar recursivamente una palabra o frase en los archivos de una carpeta. El primer argumento es el texto que se busca y el segundo es la carpeta. La salida muestra la ubicación absoluta de cada archivo con coincidencias y cuántas veces aparece el texto.

## Ejecutar en macOS

Abre Terminal y entra al repositorio:

```bash
cd "$HOME/Manjeo-de-Versiones"
git switch actividad-bash-completa
bash buscar.sh "hola" "/ruta/a/tu/carpeta"
bash buscar.sh "hola mundo" "/ruta/con espacios"
```

Las comillas mantienen las frases y rutas como un único argumento. También puedes escribir `bash buscar.sh "hola" ` y arrastrar una carpeta desde Finder a Terminal antes de presionar Enter.

## Demostración reproducible

```bash
bash demo.sh
```

El script crea archivos de ejemplo en una carpeta temporal, ejecuta el mismo `buscar.sh` y elimina únicamente esos datos de demostración al terminar. Muestra búsquedas de palabra y frase con sus rutas completas.

## Pruebas

```bash
bash -n buscar.sh
bash pruebas.sh
```

Verifican múltiples apariciones en una línea, frases, subcarpetas, rutas con espacios, caracteres literales, ausencia de coincidencias, archivos binarios e ilegibles, carpeta vacía y errores de argumentos.

## Comportamiento

- Escrito en Bash; utiliza las herramientas estándar grep, find, wc, tr y mktemp. No requiere Python ni instalaciones adicionales en macOS.
- `validar_argumentos` verifica los datos y convierte la carpeta a ruta absoluta.
- `contar_apariciones` recibe archivo y texto e imprime el conteo.
- `recorrer_y_mostrar` recorre los archivos y muestra `ruta: veces` solo para conteos mayores que cero.
- Búsqueda literal y sensible a mayúsculas: `hola` y `Hola` son diferentes.
- Cuenta coincidencias no superpuestas y también coincidencias dentro de otras palabras. Una frase debe estar contenida en una sola línea.
- Omite archivos binarios e ilegibles; no sigue enlaces simbólicos a subcarpetas. Si no encuentra coincidencias, no muestra salida.
- Código de salida 0 cuando termina correctamente, incluso sin coincidencias; 1 ante argumentos inválidos o error de recorrido.

El prompt propuesto está en `PROMPT_EQUIPO.md`. Los archivos Python anteriores se retiraron solo de esta rama y se conservan en el historial de Git.
