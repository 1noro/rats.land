---
title: "Git quick reference"
date: 2021-04-13T21:59:00+01:00
draft: false
tags: ["git", "shell"]
summary: "Listado de los comandos más recurrentes en el día a día con git."
---

## Obtener un repositorio --- *clone*

Para descargar un repositorio remoto a tu máquina local.

    git clone <https_or_ssh_link>

## Antes de hacer un *commit*

Comprobar el estado del repositorio.

    git status

Ver los cambios realizados sobre un archivo desde el último commit.

    git diff <file>

> Nótese que siempre que puedas poner un único archivo (`<file>`) en un comando,
> puedes poner un `.` para referirte a todos de forma recursiva.

Restaurar todos los cambios de un archivo al punto del último commit.

    git restore <file>

### Comandos sobre el [*staging area*](https://youtu.be/mVjHJFscwsk)

Agregar un archivo al *staging area*.

    git add <file>

Quitar un archivo del *staging area*.

    git restore ---staged <file>

## Confirmar los cambios --- *commit*

Una vez agregados los archivos al *staging area* realizar un *commit*.

    git commit -m "<commit_message>"

## Actualizar el repositorio remoto --- *push*

Una vez realizados uno o más *commits* se pueden subir los cambios a un
repositorio remoto.

    git push

Equivalente más detallada del comando anterior.

    git push origin <branch>

Encuentre una referencia que coincida con `<branch>` en el repositorio de  `origin ` (lo más probable es que encuentre  `refs `/ `heads `/ `master `/ `main `) y actualice la misma referencia (por ejemplo,  `refs `/ `heads `/ `master `/ `main `) en el repositorio de  `origin ` con él. Si el `<branch>` no existiera de forma remota, se crearía. - *Modificación sobre la definición del manual `man git push`*.

## Trabajar con ramas --- *branches*

Listar ramas **locales**.{{< footnoteRef number="1" >}}

    git branch

Crear una rama nueva y moverte a ella.

    git checkout -b <branch_name>

Cambiar de rama.

    git checkout <branch_name>

Borrar una rama local.

    git branch -d <branch_name>

Borrar una rama remota.

    git push origin ---delete <branch_name>

{{< footnoteSeparator >}}

{{< footnoteText number="1" >}}
Agregando la opción `---all` se pueden ver también las **ramas remotas**.
{{< /footnoteText >}}
