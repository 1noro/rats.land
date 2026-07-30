---
title: "Habilitar HTTP/2 en Nginx"
date: 2020-09-27T13:30:00+01:00
draft: false
tags: ["nginx", "linux"]
summary: "Aumentar la eficiencia y la seguridad de una web con el protocolo HTTP/2."
displaySummary: false
---

Utilizando la configuración de Nginx ya explicada en [este artículo]({{< relref "post/un-servidor-para-record-rat-la" >}}) para
esta misma página. Vamos a habilitar el protocolo HTTP/2 para mejorar la
eficiencia y la seguridad a la hora de ofrecer la web al usuario final. Empezaremos por editar la configuración de nuestro *Virtual Host*.

    nano /etc/nginx/conf.d/record.rat.la.conf

Una vez dentro, localizamos las siguientes líneas.

    listen [::]:443 ssl ipv6only=on; # managed by Certbot
    listen 443 ssl; # managed by Certbot

Y las modificamos de esta forma.

    listen [::]:443 ssl http2 ipv6only=on; # managed by Certbot
    listen 443 ssl http2; # managed by Certbot

Ahora buscamos esta otra línea y la comentamos con un `#`.

    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot

Justo debajo de la línea comentada agregamos la siguiente.

    ssl_ciphers EECDH+CHACHA20:EECDH+AES128:RSA+AES128:EECDH+AES256:RSA+AES256:EECDH+3DES:RSA+3DES:!MD5;

Guardamos el archivo y comprobamos si la configuración es correcta con `nginx -t`. Si todo está correcto, editamos o creamos el archivo `/etc/nginx/snippets/ssl-params.conf`, y localizamos la siguiente línea. ---Podría darse el caso en el que el archivo `/etc/nginx/snippets/ssl-params.conf` esté vacío, o no exista. En ese caso solo tendremos que agregar la línea modificada---.

    ssl_ciphers ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384;

Y la modificamos como esta.

    ssl_ciphers EECDH+CHACHA20:EECDH+AES128:RSA+AES128:EECDH+AES256:RSA+AES256:EECDH+3DES:RSA+3DES:!MD5;

Volvemos a comprobar la configuración con `nginx -t`. Si es correcta,
refrescamos la configuración del Nginx.

    systemctl reload nginx

Podemos comprobar los cambios con el siguiente comando.

    curl -I -L https://record.rat.la

A continuación se muestra un ejemplo de la salida del comando anterior.

    HTTP/2 200
    server: nginx/1.14.2
    date: Sun, 27 Sep 2020 11:46:58 GMT
    content-type: text/html; charset=UTF-8
    set-cookie: PHPSESSID=huc8hodo8l7qgii3jfbqacoas8; path=/
    expires: Thu, 19 Nov 1981 08:52:00 GMT
    cache-control: no-store, no-cache, must-revalidate
    pragma: no-cache

Ahí se puede apreciar que ahora se está utilizando el protocolo HTTP/2.

## Referencias

-   [How To Set Up Nginx with HTTP/2 Support on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-nginx-with-http-2-support-on-ubuntu-18-04)
