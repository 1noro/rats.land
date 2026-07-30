---
title: "Preguntas frecuentes"
draft: false
summary: "Aquí intentaré aclarar algunas de las cuestiones que, se me ocurre, pueden surgir a la hora de visitar esta web."
displaySummary: false
image: "images/faq-rats-1024.jpg"
featuredImage: false
---

Aquí intentaré aclarar algunas de las cuestiones que, se me ocurre, pueden surgir a la hora de visitar esta web. Por otra parte, si lo que quieres es que responda a las grandes cuestiones de la raza humana, lo que tienes que hacer es leer las publicaciones. ¿A qué estás esperando? Todas las respuestas a tus inquietudes están a un [*click*]({{< relref "post" >}}) de distancia.

## ¿Qué es esto?

La página `rats.land` es un blog/web personal autogestionado donde iré registrando mis proyectos y mis líos mentales. En el apartado ["sobre esta web"]({{< relref "info" >}}) puedes encontrar una descripción más detallada del asunto.

<!-- {{< blockMediaText src="images/faq-rats-1024.jpg" alt="Un puñado de ratas preguntándose cosas." >}}
<em>
    Y el pobre anciano Masson se hundió en la negrura de la muerte, con los locos chillidos de las ratas taladrándole los oídos.
</em>
<br>
– Henry Kuttner
{{< /blockMediaText >}} -->

{{< blockMediaText src="images/rat1-recorte-borde.png" alt="Rata triste cantando." >}}
<em>
    ¡Cómo ahora! ¿una rata? Muerto por un ducado, ¡muerto!
</em>
<br>
– Shakespeare, Hamlet
{{< /blockMediaText >}}

## ¿Por qué rats.land? {#por-que}

Originalmente, esta web se llamaba `record.rat.la`. Compré el dominio `rat.la` en busca de tres cosas: un nombre fácil de recordar, corto y asequible. Busqué durante mucho tiempo, probando múltiples combinaciones de letras, intentando evitar los números y descartando los dominios de nivel superior muy largos, estilo `.website`. Incluso llegué a utilizar generadores de palabras aleatorias para conseguir las palabras con 3 letras que encajasen mejor con mis requisitos.

Tras esa ardua búsqueda encontré en oferta el dominio `.la` y pensando un subdominio adecuado se me ocurrió "rat", como una rata cantando: *La, la, la*. —Además de darse la casualidad de que era la palabra más corta y sonora que estaba disponible—.

{{< imgLandscape src="images/ratBbg.webp" alt="Logotipo inicial de la web, una rata cantando: la la la." >}}
Antigua portada de la página
{{< /imgLandscape >}}

Esta imagen ilustra bien la chorrada en la que estaba pensando a la hora de elegir el dominio. Está dibujada por mi amiga **pepunto.reik** ([este
es su Instagram](https://www.instagram.com/pepunto.reik)) la cual fue muy amable y me ofreció varios dibujos para que yo eligiera —muchos de ellos siguen hoy en día adornando algunos rincones de la web—. Durante los primeros meses de la web fue la portada de la página hasta que mi obsesión por la simplicidad y la eficiencia en la carga me obligaron a tomar la horrible decisión de relegarla a un segundo plano. Pero en compensación la he trasladado a esta página para que no caiga en el olvido, posibilitando su futuro retorno al primer plano.

Después de tres años decido emprender una ardua, pero satisfactoria, migración que consistía en pasar de un precioso monolito en PHP que tenía como *backend* a utilizar el [famoso generador de sitios estáticos HUGO](https://gohugo.io/). Esto, a su vez, se conjuga con que estoy aprendiendo a usar AWS un poco más en serio y veo que alojar la web en [S3](https://aws.amazon.com/es/s3/) supondría una oportunidad de oro para aprender y otorgar una mayor estabilidad al sito. Pero me encontré con un problema, en [Route53](https://aws.amazon.com/es/route53/) —el servicio de DNS de AWS— no se pueden gestionar aún los dominios `.la`. Por lo que decido tomar la dura; sin embargo, necesaria decisión de cambiar de dominio —y tirar por la borda el modesto posicionamiento SEO que había trabajado con `record.rat.la`—.

El nuevo nombre es `rats.land`, un dominio que tiene muchas reminiscencias con el anterior y guarda parte del significado —ya que no estaba dispuesto a tirar por la borda la magnífica ambientación que me había trabajado poco a poco a lo largo de los años—.

La trayectoria de esta web desde sus inicios viene a demostrarme a mí mismo que soy un culo inquieto y que no soy capaz de quedarme parado por nada del mundo, siempre tengo que estar probando cosas nuevas y nunca me cansaré de hacerlo. Por esta misma razón me parece una buena idea redactar un [*changelog*]({{< relref "changelog" >}}) para recoger los cambios más importantes que han dado forma a esta página con el paso del tiempo.

<!-- ## ¿Cómo puede ser que esta web utilice Cookies?

Pues resulta que estoy interesado en experimentar con Google Analytics 4
y sus herramientas de espionaje. Así que si aceptas el magnifico
*pop-up* de consentimiento me estarás dando una valiosa información
sobre tus gustos y hábitos dentro de esta web 😈.

Puedes leer mas detalladamente todas mis razones para utilizar esta
tecnología del averno en [esta página](/cookie), donde también podrás
encontrar la [política de cookies de la
web](/cookie#politica_de_cookies). -->

## ¿Puedo compartir, citar o copiar contenido? {#acquireLicense}

Todo el contenido multimedia que se muestra en esta página se encuentra bajo la licencia [Creative Commons BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). Lo que significa que puedes compartir, copiar, redistribuir, adaptar, transformar y construir sobre el material de esta web para cualquier propósito, incluso comercial, siempre y cuando se atribuya la autoría y se comparta bajo la misma licencia. Con contenido multimedia me refiero todos los textos, imágenes, vídeos, audios... que puedas ver publicados aquí.

Por otro lado el código fuente en HTML, CSS y JS ---base necesaria para que la web funcione--- está publicado en [GitHub](https://github.com/1noro/rats.land) bajo la licencia [GNU General Public License Versión 3](https://www.gnu.org/licenses/gpl-3.0.html).

## ¿Cómo recibir notificaciones?

Para recibir actualizaciones sobre las nuevas publicaciones de la página, solo tienes que descargarte un lector de RSS en tu PC o tu *smartphone*, copiar [mi enlace de RSS](/index.xml) y agregarlo a tu feed. Por si no tenéis ni idea del tema y no queréis perder tiempo *googleando*, personalmente recomiendo [Miniflux](https://miniflux.app/) como opción *self-hosted* para todo tipo de dispositivos, [RSS Guard](https://github.com/martinrotter/rssguard) para PC y [Feeder](https://gitlab.com/spacecowboy/Feeder) o [NiceFeed](https://github.com/joshuacerdenia/NiceFeed) para Android. 

## ¿Qué zona horaria utilizas?

Todas las fechas de la web están actualmente localizadas en la zona horaria `Europe/Madrid`. Si en el futuro esto se internacionaliza más podría plantearme el cambiarlo todo a `UTC`.

## ¿Qué software utilizas?

Si me conoces, o has leído algo de este blog, ya habrás intuido que soy un ferviente defensor del software libre y una persona orgullosa de no utilizar ningún software privativo en mi *workflow* local. Me he currado una lista bastante detallada sobre el software que uso habitualmente en [esta página]({{< relref "mi-software" >}}), para que la gente que quiera buscar un reemplazo a esa "espinita" que todo entusiasta del software libre tiene cuando usa una aplicación privativa y no encuentra alternativa.

## ¡Tengo otra pregunta!

En el [footer](#footer) de la página podrás encontrar el correo electrónico de la página. Si quieres preguntarme cualquier cosa no dudes en escribirme. Estaré encantado de contestarte.
