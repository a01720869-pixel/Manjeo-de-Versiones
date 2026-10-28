def contiene_palabra(ruta, palabra):
    try:
        with open(ruta, "r", encoding="utf-8") as archivo:
            for linea in archivo:
                if palabra in linea:
                    return True

    except (OSError, UnicodeError):
        pass

    return False
