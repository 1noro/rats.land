---
title: "Perguntas frequentes"
draft: false
summary: "Aqui tentarei esclarecer algumas das questões que, ocorre-me, podem surgir à hora de visitar esta web."
displaySummary: false
image: "images/faq-rats-1024.jpg"
featuredImage: false
---

Aqui tentarei esclarecer algumas das questões que, ocorre-me, podem surgir à hora de visitar esta web. Por outra parte, se o que queres é que responda às grandes questões da raça humana, o que tens que fazer é ler as publicações. A que estás a esperar? Todas as respostas às tuas inquietudes estám a um [*click*]({{< relref "post" >}}) de distância.

## Que é isto?

A página `rats.land` é um blog/web pessoal autogerido onde irei registando os meus projectos e os meus enredos mentais. No apartado ["sobre esta web"]({{< relref "info" >}}) podes encontrar uma descrição mais detalhada do assunto.

<!-- {{< blockMediaText src="images/faq-rats-1024.jpg" alt="Um punhado de ratas a perguntarem-se cousas." >}}
<em>
    E o pobre ancião Masson afundou-se na negrura da morte, com os loucos guinchos das ratas a furarem-lhe os ouvidos.
</em>
<br>
– Henry Kuttner
{{< /blockMediaText >}} -->

{{< blockMediaText src="images/rat1-recorte-borde.png" alt="Rata triste a cantar." >}}
<em>
    Como agora! uma rata? Morto por um ducado, morto!
</em>
<br>
– Shakespeare, Hamlet
{{< /blockMediaText >}}

## Por que rats.land? {#por-que}

Originalmente, esta web chamava-se `record.rat.la`. Comprei o domínio `rat.la` em busca de três cousas: um nome fácil de lembrar, curto e assequível. Busquei durante muito tempo, provando múltiplas combinações de letras, tentando evitar os números e descartando os domínios de nível superior muito longos, estilo `.website`. Mesmo cheguei a utilizar geradores de palavras aleatórias para conseguir as palavras com 3 letras que encaixassem melhor com os meus requisitos.

Trás essa árdua busca encontrei em oferta o domínio `.la` e a pensar num subdomínio adequado ocorreu-me "rat", como uma rata a cantar: *La, la, la*. —Além de dar-se a casualidade de que era a palavra mais curta e sonora que estava disponível—.

{{< imgLandscape src="images/ratBbg.webp" alt="Logotipo inicial da web, uma rata a cantar: la la la." >}}
Antiga capa da página
{{< /imgLandscape >}}

Esta imagem ilustra bem a parvada na que estava a pensar à hora de eleger o domínio. Está desenhada pola minha amiga **pepunto.reik** ([este
é o seu Instagram](https://www.instagram.com/pepunto.reik)) a qual foi muito amável e ofereceu-me vários desenhos para que eu elegesse —muitos deles seguem hoje em dia a adornar alguns recantos da web—. Durante os primeiros meses da web foi a capa da página até que a minha obsessão pola simplicidade e a eficiência na carga me obrigaram a tomar a horrível decisão de relegá-la a um segundo plano. Mas em compensação trasladei-a a esta página para que não caia no esquecimento, possibilitando o seu futuro retorno ao primeiro plano.

Depois de três anos decido empreender uma árdua, mas satisfatória, migração que consistia em passar de um precioso monólito em PHP que tinha como *backend* a utilizar o [famoso gerador de sítios estáticos HUGO](https://gohugo.io/). Isto, à sua vez, conjuga-se com que estou a aprender a usar AWS um pouco mais a sério e vejo que alojar a web em [S3](https://aws.amazon.com/es/s3/) suporia uma oportunidade de ouro para aprender e outorgar uma maior estabilidade ao sítio. Mas encontrei-me com um problema, em [Route53](https://aws.amazon.com/es/route53/) —o serviço de DNS de AWS— não se podem gerir ainda os domínios `.la`. Polo que decido tomar a dura; no entanto, necessária decisão de mudar de domínio —e tirar pola borda o modesto posicionamento SEO que havia trabalhado com `record.rat.la`—.

O novo nome é `rats.land`, um domínio que tem muitas reminiscências com o anterior e guarda parte do significado —já que não estava disposto a tirar pola borda a magnífica ambientação que havia trabalhado pouco a pouco ao longo dos anos—.

A trajectória desta web desde os seus inícios vem demonstrar-me a mim mesmo que som um cu inquieto e que não som capaz de ficar parado por nada do mundo, sempre tenho que estar a provar cousas novas e nunca me cansarei de fazê-lo. Por esta mesma razão parece-me uma boa ideia redigir um [*changelog*]({{< relref "changelog" >}}) para recolher as mudanças mais importantes que dérom forma a esta página com o passo do tempo.

<!-- ## Como pode ser que esta web utilize Cookies?

Pois resulta que estou interessado em experimentar com Google Analytics 4
e as suas ferramentas de espionagem. Assim que se aceitas o magnífico
*pop-up* de consentimento estarás a dar-me uma valiosa informação
sobre os teus gostos e hábitos dentro desta web 😈.

Podes ler mais detalhadamente todas as minhas razões para utilizar esta
tecnologia do averno em [esta página](/cookie), onde também poderás
encontrar a [política de cookies da
web](/cookie#politica_de_cookies). -->

## Podo compartilhar, citar ou copiar conteúdo? {#acquireLicense}

Todo o conteúdo multimédia que se mostra nesta página encontra-se sob a licença [Creative Commons BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). O que significa que podes compartilhar, copiar, redistribuir, adaptar, transformar e construir sobre o material desta web para qualquer propósito, mesmo comercial, sempre e quando se atribua a autoria e se compartilhe sob a mesma licença. Com conteúdo multimédia refiro-me a todos os textos, imagens, vídeos, áudios... que podas ver publicados aqui.

Por outro lado o código fonte em HTML, CSS e JS ---base necessária para que a web funcione--- está publicado em [GitHub](https://github.com/1noro/rats.land) sob a licença [GNU General Public License Versão 3](https://www.gnu.org/licenses/gpl-3.0.html).

## Como receber notificações?

Para receber actualizações sobre as novas publicações da página, só tens que descarregar um leitor de RSS no teu PC ou no teu *smartphone*, copiar [a minha ligação de RSS](/gl/index.xml) e agregá-la ao teu feed. Por se não tendes nem ideia do tema e não queredes perder tempo a *googlear*, pessoalmente recomendo [Miniflux](https://miniflux.app/) como opção *self-hosted* para todo tipo de dispositivos, [RSS Guard](https://github.com/martinrotter/rssguard) para PC e [Feeder](https://gitlab.com/spacecowboy/Feeder) ou [NiceFeed](https://github.com/joshuacerdenia/NiceFeed) para Android.

## Que zona horária utilizas?

Todas as datas da web estám actualmente localizadas na zona horária `Europe/Madrid`. Se no futuro isto se internacionaliza mais poderia plantear-me mudá-lo tudo a `UTC`.

## Que software utilizas?

Se me conheces, ou leste algo deste blog, já haverás intuído que som um fervente defensor do software livre e uma pessoa orgulhosa de não utilizar nengum software privativo no meu *workflow* local. Trabalhei-me uma lista bastante detalhada sobre o software que uso habitualmente em [esta página]({{< relref "o-meu-software" >}}), para que a gente que queira buscar um substituto a essa "espinha" que todo entusiasta do software livre tem quando usa uma aplicação privativa e não encontra alternativa.

## Tenho outra pergunta!

No [footer](#footer) da página poderás encontrar o correio electrónico da página. Se queres perguntar-me qualquer cousa não dubides em escrever-me. Estarei encantado de contestar-te.
