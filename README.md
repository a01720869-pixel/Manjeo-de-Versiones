# Manejo de versiones con Git - Bash

Versión sencilla para la actividad de la fotografía. Rama: `manejo-versiones-bash-simple`.

## Ejecutar en tu Mac

```bash
cd "$HOME/Manjeo-de-Versiones"
git switch manejo-versiones-bash-simple
bash buscar.sh "hola" "$HOME/semanatec/documentos"
```

Cambia el texto y la carpeta por los que quieras analizar. Para una frase o una ruta con espacios, conserva las comillas.

```bash
bash buscar.sh "hola mundo" "/ruta/a/tu/carpeta"
```

El programa recibe uno o dos argumentos:

1. La palabra o frase que deseas buscar (obligatoria).
2. La carpeta que deseas analizar (opcional).

Si omites el segundo argumento, busca desde la raíz `/`, incluidos los volúmenes montados accesibles:

```bash
bash buscar.sh "hola"
```

La búsqueda completa puede tardar. Para detenerla, presiona Control + C. Se omiten archivos y carpetas protegidos por permisos; no es posible leerlos sin acceso. No uses sudo para la demostración.

## Salida

Solo muestra la ubicación absoluta de los archivos que contienen el texto, una vez por archivo, sin conteos:

```text
/ruta/a/tu/carpeta/archivo1.txt
/ruta/a/tu/carpeta/subcarpeta/archivo 2.txt
```

No imprime nada si no hay coincidencias. Distingue mayúsculas de minúsculas y busca texto literal, incluso dentro de otras palabras. No admite frases que atraviesen saltos de línea. Omite binarios y archivos ilegibles. No sigue enlaces simbólicos. Los errores de acceso durante el recorrido se omiten; la búsqueda puede ser parcial. Argumentos incorrectos producen código 1; la búsqueda normal termina con 0.

## Demostración y pruebas en Bash

```bash
bash demo.sh
bash pruebas.sh
```

La demostración crea datos temporales y ejecuta `buscar.sh`. Las pruebas verifican palabra, frase, subcarpetas, nombres con espacios, búsqueda literal, omisión de binarios e ilegibles y errores de argumentos. El valor predeterminado `/` se comprueba sustituyendo find en la prueba para evitar recorrer todo el Mac.

## Cómo funciona el código

`buscar.sh` valida los argumentos, usa `/` cuando falta la carpeta, obtiene su ruta completa y ejecuta find con grep:

- `find ... -type f`: recorre los archivos de la carpeta y sus subcarpetas.
- `-exec ... {} +`: entrega grupos de rutas a grep, respetando los espacios.
- `grep -I -l -F`: omite binarios, muestra solo nombres y busca texto literal.

No usa Python ni requiere instalaciones adicionales en macOS.

## Trabajo del equipo y ramas

La fotografía exige una contribución real por integrante visible en Git. Esta rama contiene una implementación; no acredita por sí sola las contribuciones de los compañeros. Cada integrante debe crear su rama desde esta versión, hacer su aportación y publicarla con sus propios commits. Después pueden revisarlas mediante Pull Requests.

Ejemplo para un compañero (sustituir el nombre de la rama):

```bash
git fetch origin
git switch -c aporte-nombre origin/manejo-versiones-bash-simple
# Editar y comprobar el cambio.
git add archivo-modificado
git commit -m "Describe la aportacion realizada"
git push -u origin aporte-nombre
```
