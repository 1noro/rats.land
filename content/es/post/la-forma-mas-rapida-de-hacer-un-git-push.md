---
title: "La forma más rápida de hacer un git push"
mainTitle: "Git push"
subtitle: "La forma más rápida"
date: 2020-09-30T12:40:00+01:00
draft: false
tags: ["git", "shell"]
summary: "Subir tus cambios de un repositorio git a un origen remoto de forma rápida y sencilla."
displaySummary: false
---

Estos tres comandos, que se deben copiar y pegar en bloque, son la forma más sencilla para subir tus cambios de un repositorio git a un origen remoto, como *GitHub*, *GitLab*, etc. ---Como requisito previo, se debe haber configurado el usuario y el correo electrónico. Y situar la terminal en la carpeta raíz del repositorio (la primera)---.

Para configurar el usuario y el correo electrónico se deben ejecutar los siguientes comandos:

    git config ---global user.name "nombre"
    git config ---global user.email "email@example.com"

Una vez se hayan cumplido los requisitos previos, solo hay que copiar **todos** los comandos que vienen a continuación y los pegamos en la terminal.

    git add . \
    git commit -m "repositorio actualizado" \
    git push

Si tenemos clonado el repositorio por *SSH* no hace falta que pongáis la contraseña, pero si lo tenéis por *HTTPS*, os solicitará el nombre de usuario y la contraseña de *GitHub*, *GitLab*, etc.
