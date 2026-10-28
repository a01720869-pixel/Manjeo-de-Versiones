import os


def listar_archivos(carpeta):
    for ubicacion, carpetas, archivos in os.walk(carpeta):
        for archivo in archivos:
            yield os.path.abspath(os.path.join(ubicacion, archivo))
