---
title: "Expandir una partición EXT4 de forma dinámica"
date: 2021-11-14T21:16:00+01:00
draft: false
# tags: ["linux", "comandos", "ext4", "particiones", "discos"]
tags: ["linux", "shell"]
summary: "Aumentar el tamaño de una partición EXT4 sin tener que formatear el disco duro."
---

El sistema de archivos EXT4 te permite redimensionar las particiones de
un disco duro sin tener que apagar el PC ni borrar tus datos. En caso de
no utilizar el 100% de tu disco duro, o si estas gestionando discos
virtuales, estes sencillos comandos te pueden facilitar la vida sin
tener que volver a formatear el disco.{{< footnoteRef number="1" >}}

## Aumentar partición hasta un tamaño exacto

Suponiendo que la partición que quieres expandir es `/dev/sdb1` (**la
única del disco**), con un tamaño inicial de **200MB**, y que quieres
que su tamaño sea de **400MB**, podemos ejecutar los siguientes
comandos:

    sudo parted /dev/sdb resizepart 1 400M
    sudo resize2fs /dev/sdb1

## Aumentar partición hasta ocupar la totalidad del disco

Suponiendo que la partición que quieres expandir es `/dev/sdb1` (**la
única del disco**), cuyo tamano es **menor a la totalidad del disco**,
podemos ejecutar los siguientes comandos para que lo ocupe todo:

    sudo parted /dev/sdb resizepart 1 100%
    sudo resize2fs /dev/sdb1

Para concluir, solo tengo que recordar que, cualquier mejora o precaución que creas necesaria añadir a estos comandos es bienvenida, en tal caso solo debes hacérmelo saber a través del [medio que prefieras](#contacto).

{{< footnoteSeparator >}}

{{< footnoteText number="1" >}}
Antes de realizar cualquier modificación en el disco es necesario señalar la importancia de tener un backup reciente a mano por si metemos la pata.
{{< /footnoteText >}}
