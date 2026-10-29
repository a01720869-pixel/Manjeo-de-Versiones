# Prompt del equipo – Buscador de palabras en Bash

Necesitamos desarrollar un programa en Bash Shell que permita buscar una palabra o frase dentro de los archivos de una carpeta y sus subcarpetas.

El programa debe recibir dos argumentos desde la terminal: primero la palabra o frase que se desea buscar y después la ruta de la carpeta donde se realizará la búsqueda.

El programa debe cumplir con las siguientes condiciones:

1. **Validar los argumentos:** comprobar que se reciban exactamente dos argumentos, que la palabra no esté vacía y que la carpeta exista. Si hay un error, mostrar un mensaje y utilizar `exit 1`.

2. **Contar las apariciones:** crear una función que reciba un archivo y una palabra, y devuelva cuántas veces aparece. Debe ignorar archivos binarios y aquellos que no se puedan leer.

3. **Recorrer los archivos:** utilizar el comando `find` para revisar los archivos de la carpeta y sus subcarpetas.

4. **Mostrar resultados:** imprimir únicamente los archivos donde existan coincidencias, utilizando el formato `ruta: veces`.

5. **Organizar el código:** dividir el programa en tres funciones llamadas `validar_argumentos`, `contar_apariciones` y `recorrer_y_mostrar`, para que cada integrante del equipo pueda desarrollar una parte diferente.

6. **Integrar el programa:** crear un script principal llamado `buscador.sh` que conecte las tres funciones y pueda ejecutarse desde la terminal.

Utilizar comandos compatibles con Bash, incluir comentarios sencillos en el código y explicar cómo ejecutar el programa. También proporcionar ejemplos de pruebas con argumentos correctos e incorrectos para verificar su funcionamiento.
