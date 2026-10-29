
# Buscador de palabras en Bash

## Descripcion

Este proyecto consiste en crear un programa en Bash que permita buscar una palabra o frase dentro de los archivos de una carpeta y sus subcarpetas.

El programa muestra la ubicacion de cada archivo donde se encuentra la palabra y el numero de veces que aparece.

## Integrantes

- Integrante 1: Validacion de argumentos.
- Integrante 2: Conteo de apariciones.
- Integrante 3: Recorrido de archivos, resultados y documentacion.

## Archivos del proyecto

- buscador.sh: Programa principal.
- validar.sh: Valida los argumentos.
- contar.sh: Cuenta las apariciones.
- recorrer.sh: Recorre carpetas y muestra resultados.

## Ejecucion

Abrir una terminal dentro de la carpeta del proyecto.

Ejecutar:

bash buscador.sh palabra carpeta

Ejemplo:

bash buscador.sh hola documentos

## Funcionamiento

1. El programa recibe una palabra y una carpeta.
2. Verifica que los argumentos sean correctos.
3. Recorre los archivos de la carpeta y sus subcarpetas.
4. Cuenta las apariciones de la palabra en cada archivo.
5. Muestra la ruta y el numero de coincidencias.
6. Omite archivos binarios o que no se pueden leer.

## Trabajo colaborativo

Cada integrante desarrollo su funcion en una rama de GitHub.

Los cambios se integran mediante Pull Requests para formar el programa completo.

## Uso de IA

Se utilizo IA como apoyo para plantear la estructura del programa, comprender los comandos de Bash y revisar posibles errores. El codigo se debe verificar mediante pruebas.
