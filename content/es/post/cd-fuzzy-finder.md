---
title: "CD fuzzy finder"
date: 2022-09-24T16:59:00+01:00
draft: false
# tags: ["bash", "fzf", "cli", "terminal", "tips", "shell", "linux"]
tags: ["linux", "shell"]
summary: "Presento aquí mi solución personal al problema de moverse rápido entre directorios por la Shell de GNU/Linux."
displaySummary: false
# image: "https://recordratla-public-res.s3.eu-south-2.amazonaws.com/img/20220924/fzf-1300.jpg"
# featuredImage: false
---

Presento aquí mi solución personal al problema de moverse rápido entre directorios por la Shell de GNU/Linux. Resulta que durante mis largas jornadas de trabajo, donde estoy
constantemente entrando y saliendo de carpetas, he notado que moverme
con el ratón por el explorador de archivos y luego hacer *click* derecho
en un hueco vacío para abrir un terminal en ese directorio no es un
proceso tan rápido como me gustaría. Más de una vez me he encontrado en
situaciones en las que estoy recorriendo el mismo camino por cuarta o
quinta vez en la misma jornada.

Normalmente yo no necesito entrar a los directorios desde un entorno
gráfico, suelo acceder para utilizar Git en modo *cli*, gestionar
archivos o abrir un proyecto entero en el editor de código de turno, con
comandos como `nvim .` o `code .` los cuales me ahorran mucho tiempo
ejecutándolos desde el directorio que me interesa, antes hacer el
proceso inverso abriendo estos programas desde el entorno gráfico y
luego navegar hasta el directorio desde el.

## Solución

Yo ya estoy muy acostumbrado a utilizar el atajo de teclado `Ctrl+Alt+T`
para abrir una nueva instancia de la terminal situada en el directorio
*home* de mi usuario. Y se me ocurrió que si conseguía llegar al
directorio deseado lo más rápido posible desde ahí acabaría
agradeciéndolo.

Conocía el programa `fzf` ([enlace al repo](https://github.com/junegunn/fzf))
que permite hacer una búsqueda sobre una lista de elementos que le
mandes como input. Pero realmente, a pesar de el enorme potencial que
tiene aún no le había encontrado una utilidad muy clara en mi
*workflow*.

Entonces en un momento de lucidez me vino a la mente el siguiente
comando.{{< footnoteRef number="1" >}}

    cd "$(find * -type d | fzf)"

Lo que hace básicamente es buscar todos los directorios a partir del
actual con el comando `find` y pasar el output al `fzf`, dónde nosotros
buscaremos y seleccionaremos a dónde queremos ir. Después el resultado
seleccionado se le pasa como argumento al comando `cd` el cual nos lleva
a la dirección solicitada. Y las dobles comillas se las ponemos por si
el directorio solicitado tiene alguna clase de espacio o carácter
especial.

Y ahora que ya tenía lo que yo quería solo necesitaba que fuese
accesible lo más rápido posible, por lo que se me ocurrió agregarlo como
un *bind*{{< footnoteRef number="2" >}} en mi `~/.bashrc`, aunque otra opción buena habría sido
agregarlo como alias, pero sin embargo creo que el *bind* es más rápido
en este caso.

Al final quedó de esta forma para **bash**, en mi `~/.bashrc` agregué la
siguiente línea.

    bind '"\C-g":"cd \"$(find * -type d | fzf)\"\C-m"'

Y en caso de usar **zsh** habría que agregar lo siguiente al `~/.zshrc`.

    bindkey -s '^g' 'cd "$(find * -type d | fzf)"^M'

## Variaciones

Hay que tener en cuenta que este comando ignora las carpetas ocultas a
propósito porque a mi me conviene, pero si quisieras listar también esos
directorios solo habría que modificar el comando `find`. Una posible
solución podría ser algo como lo siguiente.

    cd "$(find $(pwd) -type d | fzf)"

Otra variante para el comando `find` podría ser la posibilidad de
ignorar ciertos nombres de carpetas. Por ejemplo, en sistemas macOS no
me gustaría buscar dentro del contenido de las carpetas `Library` o
`Applications`, por lo que el comando quedaría de la siguiente forma.

    cd "$(find * \( -path Library -o -path Applications -o -path opt \) -prune -o -print | fzf)"

He de decir que aún estoy empezando a incorporar esta nueva idea a mi día a día por lo que puede que el comando y, como consecuencia, este articulo sean actualizados a medida que pase el tiempo.

{{< footnoteSeparator >}}

{{< footnoteText number="1" >}}
Nótese que es necesario haber instalado `fzf` para que funcione. He aquí la [guía de instalación](https://github.com/junegunn/fzf#installation).
{{< /footnoteText >}}

{{< footnoteText number="2" >}}
En mi caso *bindeé* la combinación de teclas `Ctrl+G` para ejecutar la sentencia.
{{< /footnoteText >}}
