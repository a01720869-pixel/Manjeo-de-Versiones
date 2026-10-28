import sys
import os
from recorrido import listar_archivos
from busqueda import contiene_palabra


def main():
    if len(sys.argv) < 2 or len(sys.argv) > 3:
        print("Uso: python3 main.py palabra [carpeta]")
        return

    palabra = sys.argv[1]

    if palabra == "":
        print("Escribe una palabra que no esté vacía.")
        return

    if len(sys.argv) == 3:
        carpeta = os.path.expanduser(sys.argv[2])
    else:
        carpeta = "/"

    if not os.path.isdir(carpeta):
        print("La carpeta no existe o no es una carpeta.")
        return

    for ruta in listar_archivos(carpeta):
        if contiene_palabra(ruta, palabra):
            print(ruta)


if __name__ == "__main__":
    main()
