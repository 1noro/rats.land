# rats.land

Blog/web personal autogestionado donde iré registrando mis proyectos y mis líos mentales.

Debido a que siempre estoy iniciando y abandonando nuevos proyectos, y que cada dos por tres no paro de saltar entre centrarme en la programación, en las redes o en las configuraciones de GNU/Linux, entre otras muchas cosas. He decidido llevar un registro más o menos diario, semanal, o por lo menos ir actualizando regularmente lo que voy haciendo y dejarlo por escrito. Para que yo, al retomar ese proyecto en el futuro, pueda leer y volver al contexto en el que me encontraba. Porque actualmente tengo tantos frentes abiertos que ya no sé ni que estaba haciendo antes del verano ni lo que voy a hacer ahora.

Bueno, si sé lo que voy a hacer ahora: programar una especie de blog muy sencillo donde escribir o editar una publicación suponga el mínimo esfuerzo para llevar un seguimiento de las cosas que estudio, investigo, pruebo y pongo en práctica para no tener que reinventar la rueda cada vez que me pongo delante de un TXT en blanco.

Además, esto viene porque ahora me apetece hacer una web, me apetece hacer algo muy sencillo y fácil de gestionar a nivel interno. Hoy por la mañana leí [esta maravilla](http://motherfuckingwebsite.com/) y me incitó a empezar este proyecto. ¿Ves? Este es un buen ejemplo de lo que quiero hacer con este blog, acordarme del motivo y el procedimiento que sigo al hacer un proyecto.

Intentaré cumplir esta visión en la medida de lo posible y no parar de sentir curiosidad por cosas nuevas.

## Desarrollo local

La web se compila con **Hugo v0.164.0 (edición _extended_)** dentro de un
contenedor Docker, de forma que el build es reproducible y no hace falta
instalar Hugo en la máquina: sólo se necesita Docker.

La versión de Hugo está fijada en la imagen `infra/Dockerfile` y toda la
operativa se maneja con el `Makefile` de la raíz (autodescriptivo):

```console
$ make            # lista todos los targets disponibles
$ make server     # servidor de desarrollo con recarga en vivo (http://localhost:1313)
$ make build      # genera el sitio estático en ./public
$ make new CONTENT=post/mi-post.md   # crea una entrada nueva (en content/es/)
$ make clean      # borra public/ y resources/
$ make deploy-dry # muestra qué publicaría en S3 sin tocar nada
```

Variables sobrescribibles, por ejemplo: `make server PORT=8080` o
`make build HUGO_VERSION=0.165.0`.

## Multiidioma

La web se publica en **castellano** (idioma por defecto) y en **gallego
reintegrado (norma AGAL)**. Cada idioma tiene su propio `contentDir`:

```
content/
├── es/     → castellano, servido en la raíz:  https://rats.land/
└── gl/     → gallego,    servido en /gl/:     https://rats.land/gl/
```

El castellano se queda en la raíz a propósito, para no romper ninguna URL
histórica. Hugo genera solo el redirect de `/es/` → `/` y coloca `robots.txt` y
el índice de sitemaps en la raíz.

**No hace falta traducir todo.** Hugo construye cada idioma como un sitio
independiente, así que el archivo, los tags, el RSS y el sitemap gallegos solo
listan lo que exista en `content/gl/`. Ahora mismo en gallego están las páginas
fijas y una única publicación; el resto vive solo en castellano y eso no rompe
nada. Lo que sí conviene mantener traducido son las páginas a las que enlazan
el header y el footer (`info`, `faq`, `post`, `tags`) y la página del autor
(`inoro`), porque si faltan esos enlaces dan 404 en `/gl/`.

### Añadir una traducción

1. Crea el fichero en `content/gl/` con la misma ruta relativa que el
   castellano. `make new` **siempre** escribe en `content/es/` (con
   `contentDir` por idioma el flag `--contentDir` no lo cambia), así que los
   ficheros gallegos se crean a mano.
2. Si el nombre del fichero o del bundle **no** coincide con el castellano,
   añade el mismo `translationKey` en el front matter de **ambos**. Sin él Hugo
   no las enlaza y el selector de idioma y las etiquetas `hreflang` se quedan
   vacíos, en silencio. Ejemplos ya en el repo:

   | Castellano | Gallego | `translationKey` |
   | --- | --- | --- |
   | `es/mi-software.md` | `gl/o-meu-software.md` | `mi-software` |
   | `es/post/a-traves-de-la-ventana/` | `gl/post/atraves-da-janela/` | `a-traves-de-la-ventana` |

3. Los `relref` se resuelven **dentro del mismo idioma**: si apuntas a una
   página que no existe en gallego, el build falla.
4. Las imágenes de un *page bundle* no hay que duplicarlas: al enlazarse las
   traducciones, el bundle gallego hereda los recursos del castellano.

### Textos de la interfaz

Las cadenas del tema (navegación, `aria-label`, la cita de la cabecera, el 404…)
viven en tablas de traducción dentro del propio tema:

```
themes/hugo-theme-ratsland-bookstyle/i18n/{es,gl}.toml
```

Si falta una clave, Hugo **no falla**: cae al idioma por defecto y, si tampoco
está, devuelve cadena vacía. Los targets `build` y `server` pasan
`--printI18nWarnings` para que esos casos se vean.

> **Aviso:** el tema alternativo `hugo-theme-ratsland-sans-serif` (desactivado
> en `hugo.toml`) **no** tiene soporte i18n. Si se reactiva habrá que
> portarle las tablas `i18n/` y los `relLangURL`.

## Temas de HUGO que me gustan

- https://themes.gohugo.io/themes/hugo-theme-nostyleplease/
- https://themes.gohugo.io/themes/bare-hugo-theme/
- https://themes.gohugo.io/themes/hugo-vitae/
- https://themes.gohugo.io/themes/hugo-papermod/
- https://themes.gohugo.io/themes/hugo-ficurinia/
- https://themes.gohugo.io/themes/hugo-blog-awesome/
- https://themes.gohugo.io/themes/hugo-theme-cactus-plus/
- https://themes.gohugo.io/themes/hugo-theme-sk1/
- https://themes.gohugo.io/themes/archie/
- https://themes.gohugo.io/themes/slick/
- https://themes.gohugo.io/themes/hugo-rocinante/

## Webs de inspiración para la temática de las imágenes

- https://wilburwhateley.tumblr.com/
- https://mockman.com/comic/lovecraft-sketch-mwf-pickmans-model-2/

## Licencias

Este trabajo está bajo la licencia GPL-3.0 en lo que respecta al software y 
bajo la Creative Commons BY-SA-4.0 con respecto al resto de contenido 
multimedia (imágenes, textos, etc).

`SPDX-License-Identifier: GPL-3.0-or-later AND CC-BY-SA-4.0`
