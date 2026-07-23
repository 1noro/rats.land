# syntax=docker/dockerfile:1
#
# Imagen reproducible para compilar rats.land con una versión de Hugo FIJADA.
#
# Se basa en las imágenes community de hugomods (https://docker.hugomods.com),
# concretamente en la variante «extended + git»:
#   - extended (sin prefijo `std`): imprescindible porque el tema transpila SCSS
#     mediante `toCSS` (libsass), disponible sólo en la edición extended.
#   - git (sufijo `-git`): imprescindible porque hugo.toml usa
#     `enableGitInfo = true`, que necesita el binario de git en el contenedor.
#
# La versión se controla con el ARG HUGO_VERSION (ver el Makefile de la raíz).

ARG HUGO_VERSION=0.164.0
FROM hugomods/hugo:git-${HUGO_VERSION}

# Al montar el repositorio como volumen, su propietario (el UID del host) no
# coincide con el del contenedor y git aborta con «detected dubious ownership»,
# lo que rompería enableGitInfo. Marcamos cualquier ruta como segura para que
# funcione sea cual sea el usuario con el que se ejecute el contenedor.
RUN git config --system --add safe.directory '*'

WORKDIR /src
