---
title: "Genesis"
mainTitle: "Genesis"
date: 2020-09-18T14:57:00+02:00
modified: 2022-12-15T19:57:00+01:00
draft: false
# tags: ["web", "genesis", "php", "html5", "css3", "javascript", "diseño"]
tags: ["web", "php", "html", "css", "javascript"]
summary: "Intentaré reflexionar sobre el origen de esta web, su estructura y su estilo."
displaySummary: false
image: "genesis-2001-1190.jpg"
---

> *Nota: esta publicación está desactualizada y no se corresponde con cómo ha acabado siendo esta web. Sin embargo, sigue siendo ilustrativa a la hora de explicar las razones por las que comencé este proyecto, y basándonos en este podrá verse cómo ha evolucionado desde la idea original. En [esta sección de las FAQ]({{< relref "faq#por-que" >}}) explico el porqué de la migración de dominio.*

{{< imgLandscape src="genesis-2001-1190.jpg" alt="Primera escena de 2001: Una odisea del espacio" >}}
Y dijo Dios: Sea la luz; y fue la luz. — Genesis 1:3
{{< /imgLandscape >}}

El concepto de esta aventura internáutica se basa en la simplicidad.
Aprovechando ya las características de HTML5 y un poco de PHP crearé una
web estilo Blog basada únicamente en su contenido, sus entradas, con un
diseño **muy** básico y pocos estilos.

Esto implica que la base de la web será un marco igual para cada página,
es decir, un header y un footer iguales para toda la web y que el
contenido de la página sea un artículo. Adiós a las páginas especiales,
adiós a la biografía, adiós a la página de contacto. Todo será un marco
y un contenido.

## Estructura interna

La página en sí tiene poca cosa, consta únicamente de un
`index.php` y una carpeta *articles* donde se guardan los
diferentes posts. El `index.php`, fiel al concepto original de
la web, es únicamente un marco de header-footer donde en en el medio se
coloca el contenido. Además he extremado la simplicidad basándome en que
por el momento no hay suficientes lineas de código en este archivo como
para dividir el HTML, el CSS y el PHP en tres, por lo que así me ahorro
tener que cargar archivos remotos, exceptuando el texto del artículo.

Los archivos de los posts, o artículos, tienen una estructura muy
simple, lo único que se debe respetar son dos cocas; una es el formato
del nombre para el archivo:
`AAAAMMDDhhmma-titulo-del-articulo.html`, donde `AAAA`
es el año, `MM` es el mes, `DD` es el día,
`hh` es la hora, `mm`, son los minutos y donde
`a` es el id del autor. Y otra es que la primera línea del
archivo debe contener el título rodeado de los tags HTML `<h2></h2>`. El
resto del artículo es HTML puro, por lo general siempre debería
prevalecer la sintaxis básica de etiquetas HTML5 pero en caso de ser
necesario se pueden agregar scripts en JavaScript o estilos CSS
personalizados dentro del propio archivo del artículo.

## El estilo

Debido a que la tendencia actual en el diseño de páginas web consiste en
basarse únicamente en `div` y `span` para, formatearlos más tarde con
CSS, yo nunca había utilizado las etiquetas HTML5 dándoles un uso
correcto, ni utilizándolas para lo que realmente se habían concebido.
Pero esta vez me he propuesto usarlas. Utilizarlas para la mayor parte
del formato de texto de los artículos de esta web. Gracias a ello he
descubierto que realmente el HTML5 es un lenguaje que no requiere de CSS
para cualquier cosa.

Tanto es este afán mío por explotar por completo el HTML que por el
momento este es todo el CSS que he necesitado:

    body {
        background-color: #EDD1B0;
        color: #000000;
        font-size: 1.35em;
        font-family: Times, Serif;
    }

    header, footer, p.center {
        text-align: center;
    }

    div#content {
        width: 100%;
        max-width: 750px;
        margin: 0px auto;
    }

    pre {
        padding: 10px;
        overflow: auto;
    }

    pre, code {
        background-color: #ffffee;
    }

### Listado de etiquetas útiles para formatear texto rápido en HTML5

-   `<b>`: Negrita.
-   `<i>`: Cursiva.
-   `<code>`: Código informático.
-   `<samp>`: Salida de muestra de un programa de computadora.
-   `<pre>`: Bloque de texto pre-formateado.
-   `<blockquote>`: Cita indentada en bloque.
-   `<hr>`: Linea horizontal.
-   `<br>`: Salto de línea.
-   `<wbr>`: Indica, en medio de una larga cadena de caracteres, donde
    cortarla con un salto de línea, si es necesario.

### Sobre colores y fuentes

Puede que la selección de colores resulte un tanto\... como decirlo\...
horrorosa. Pero en mi defensa diré que me he basado en un
[paper](https://www.cs.cmu.edu/~jbigham/pubs/pdfs/2017/colors.pdf)
para elegir la combinación de colores fondo/letra. Esta tonalidad de
fondo `#edd1b0` (melocotón) sobre el negro de la tipografía es
la que más me ha convencido de las tres opciones que daba el artículo
como conclusión. Según el, tanto el `#edd1b0` (melocotón), como
el `#EDDD6E` (naranja) o el `#F8FD89` (amarillo),
todos ellos con letra negra, facilitan la lectura de texto en pantalla
para personas con, o sin dislexia.

De todas formas una elección de color si que va en contra completamente
de lo que indica el anterior artículo. Se trata de el verde
(`#dfdebe`) que escogí para resaltar los cuadros de código
sobre el fondo melocotón. Para llegar a este color lo consulté con la
[encicolorpedia](https://encycolorpedia.es/edd1b0) y lo
encontré en la sección de análogos.

De todas formas la elección del color, aunque yo creo que estoy contento
con ella, por el momento queda bajo revisión. Y en el futuro me gustaría
añadir un selector de temas estilo
[4chan](https://4chan.org) donde también agregare el
cada vez más popular *dark mode*, entre otros que a mi me gusten.

Con respecto a la fuente las cosas han sido más fáciles. Posiblemente
porque no leí tanto para elegirla, y debido a que ya tenía una idea en
la cabeza de que debería ser una estilo `Serif`. Todo esto
motivado por mi obsesión con `LaTeX` y que su fuente por
defecto es la `Computer Modern`.

Otro elemento fundamental con respecto a la selección de la fuente fue
que, para garantizar el principio de simplicidad máximo que me propuse,
debía cargarse de forma local desde el equipo (lo que se denomina como
*Web Safe Font*), no descargarse desde el servidor remoto junto a la
página, como se hace hoy día en muchos sitios.

Por estos dos motivos elegí la letra `Times` para los
dispositivos que la tuvieran instalada y, como segunda opción,
concretamente porque los dispositivos Android no traen la letra
`Times` instalada, indico que el dispositivo elija la letra
estilo `Serif` que tenga por defecto.

## Webs que me inspiraron

-   [motherfuckingwebsite.com](http://motherfuckingwebsite.com/)
-   [mango.pdf.zone](https://mango.pdf.zone/)

## Referencias

-   [Good Background Colors for Readers: A Study of People with and
    without
    Dyslexia](https://www.cs.cmu.edu/~jbigham/pubs/pdfs/2017/colors.pdf)
-   [What is the best color combination for on screen
    reading?](https://ux.stackexchange.com/questions/3282/what-is-the-best-color-combination-for-on-screen-reading)
-   [White text on black
    background](https://ux.stackexchange.com/questions/551/white-text-on-black-background)
-   [The 20 Best HTML Web Fonts To Use In
    2020](https://www.hostinger.com/tutorials/best-html-web-fonts)
