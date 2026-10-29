# Manjeo-de-Versiones

## Búsqueda de palabras y frases con Bash

`buscar.sh` recibe dos argumentos: el texto que se busca y la carpeta que se analiza. Recorre sus subcarpetas y muestra únicamente los archivos con coincidencias:

```text
/ruta/completa/archivo.txt: numero_de_apariciones
```

### Uso

Requiere Bash, grep, find, wc y tr (Linux, macOS o Git Bash).

```bash
bash buscar.sh "hola" "/ruta/a/la/carpeta"
bash buscar.sh "hola mundo" "/ruta/con espacios"
```

Usa comillas para las frases y las rutas con espacios. La búsqueda es literal, distingue mayúsculas y minúsculas y cuenta coincidencias no superpuestas dentro de cada línea, incluso dentro de otras palabras. No admite frases que atraviesen saltos de línea. Omite archivos binarios e ilegibles. Si no encuentra coincidencias, no imprime nada.

Argumentos incorrectos, texto vacío o una carpeta inexistente producen un mensaje de error y código de salida 1.

### Funciones

- `validar_argumentos`: verifica los dos argumentos y obtiene la ruta completa.
- `contar_apariciones`: recibe archivo y texto; imprime el número de coincidencias.
- `recorrer_y_mostrar`: recorre con find y muestra `ruta: veces` cuando el conteo es mayor que cero. Admite nombres con espacios.

### Prompt propuesto para el equipo

> Genera un script Bash llamado buscar.sh que reciba exactamente dos argumentos: primero una palabra o frase y segundo la carpeta a analizar. Divide el programa en validar_argumentos, contar_apariciones y recorrer_y_mostrar. Valida que el texto no esté vacío y que la carpeta exista; ante errores imprime un mensaje por stderr y termina con exit 1. Convierte la carpeta a una ruta completa. Recorre recursivamente sus archivos con find, admitiendo rutas con espacios. Cuenta todas las coincidencias literales no superpuestas por línea con grep -I -o -F, distinguiendo mayúsculas y minúsculas, y omite binarios e ilegibles. Muestra la ruta completa y el número de apariciones con el formato "ruta: veces", únicamente si es mayor que cero. Incluye comentarios y ejemplos de ejecución.

Este prompt documenta la especificación propuesta para esta entrega; no constituye un registro de un acuerdo previo del equipo.

### Prueba reproducible

```bash
mkdir -p /tmp/prueba-busqueda/subcarpeta
printf 'hola mundo\nhola hola\n' > /tmp/prueba-busqueda/archivo1.txt
printf 'otra linea\nhola mundo\n' > /tmp/prueba-busqueda/subcarpeta/archivo2.txt
bash buscar.sh "hola" /tmp/prueba-busqueda
```

Resultado (el orden puede variar):

```text
/tmp/prueba-busqueda/archivo1.txt: 3
/tmp/prueba-busqueda/subcarpeta/archivo2.txt: 1
```

El workflow `.github/workflows/demostracion-bash.yml` ejecuta el programa completo y comprueba palabras, frases, subcarpetas, rutas con espacios, texto literal, archivos omitidos y errores de argumentos. Los datos se crean temporalmente en el runner.

Los cambios de esta entrega están en la rama `validar-argumentos`, asociada al PR #1; no se han fusionado a main.
