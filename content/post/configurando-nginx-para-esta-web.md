---
title: "Montar un servidor para record.rat.la"
date: 2020-09-19T01:40:00+02:00
draft: false
tags: ["nginx", "debian", "php", "web"]
---

> *Nota: esta publicación está desactualizada y no se corresponde con la
> configuración actual del servidor. Sin embargo sigue siendo
> ilustrativa a la hora de explicar la configuración de un servidor web
> Nginx.*

Como por el momento esta web será para uso personal, y no tendrá una
enorme carga de trabajo, voy a optar por instalarla en una máquina
virtual [Debian](https://www.debian.org/index.es.html) 10 en mi servidor
[Proxmox](https://www.proxmox.com/en/).

Aprovechando que siempre quise tener una web bajo un servidor
[Nginx](https://www.nginx.com/) en ved de
[Apache2](https://httpd.apache.org/), voy a utilizar esta oportunidad
para aprender.

Como primer paso voy a descargar mi web en el directorio
`/var/wwww`.

    cd /var/wwww
    git clone https://github.com/1noro/record.rat.la.git
    chmod 777 -R record.rat.la.git

## Configurando Nginx en Debian 10

    apt install git nginx php-fpm

En el archivo `/etc/php/7.3/fpm/php.ini` cambiamos
`;cgi.fix_pathinfo=1` por `cgi.fix_pathinfo=0`.

    systemctl restart php7.3-fpm.service

Hacemos una copia de seguridad del archivo
`/etc/nginx/sites-available/default` antes de modificarlo.

Tomando como referencia `/etc/nginx/sites-available/default`
creamos `/etc/nginx/conf.d/record.rat.la.conf`.

    cp /etc/nginx/sites-available/default /etc/nginx/conf.d/record.rat.la.conf

Luego comentamos todas las lineas de
`/etc/nginx/sites-available/default` para que quede \"vacío\".

Ahora editamos `/etc/nginx/conf.d/record.rat.la.conf`.

### `record.rat.la.conf` original

    server {
        listen 80 default_server;
        listen [::]:80 default_server;

        # SSL configuration
        #
        # listen 443 ssl default_server;
        # listen [::]:443 ssl default_server;
        #
        # Note: You should disable gzip for SSL traffic.
        # See: https://bugs.debian.org/773332
        #
        # Read up on ssl_ciphers to ensure a secure configuration.
        # See: https://bugs.debian.org/765782
        #
        # Self signed certs generated by the ssl-cert package
        # Don't use them in a production server!
        #
        # include snippets/snakeoil.conf;

        root /var/www/html;

        # Add index.php to the list if you are using PHP
        index index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            try_files $uri $uri/ =404;
        }

        # pass PHP scripts to FastCGI server
        #
        #location ~ \.php$ {
        #    include snippets/fastcgi-php.conf;
        #
        #    # With php-fpm (or other unix sockets):
        #    fastcgi_pass unix:/run/php/php7.3-fpm.sock;
        #    # With php-cgi (or other tcp sockets):
        #    fastcgi_pass 127.0.0.1:9000;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny all;
        #}
    }


    # Virtual Host configuration for example.com
    #
    # You can move that to a different file under sites-available/ and symlink that
    # to sites-enabled/ to enable it.
    #
    #server {
    #   listen 80;
    #   listen [::]:80;
    #
    #   server_name example.com;
    #
    #   root /var/www/example.com;
    #   index index.html;
    #
    #   location / {
    #       try_files $uri $uri/ =404;
    #   }
    #}

### Modificaciones

-   En primer lugar, necesitamos agregar `index.php` como el
    primer valor de nuestra directiva de índice para que los archivos
    denominados `index.php` se sirvan, si están disponibles,
    cuando se solicita un directorio.
-   Podemos modificar la directiva `server_name` para apuntar al nombre
    de dominio de nuestro servidor o a la dirección IP pública.
-   Para el procesamiento real de PHP, solo necesitamos descomentar un
    segmento del archivo que maneja las solicitudes de PHP. Éste será el
    bloque de ubicación `~.php$`, el fragmento
    `fastcgi-php.conf` incluido y el socket asociado con
    `php-fpm`.
-   También hay que eliminar los comentarios del bloque de ubicación que
    trata con archivos `.htaccess`. Nginx no procesa estos
    archivos. Si alguno de estos archivos encuentra la forma de llegar a
    un documento root, no deben ser servidos a los visitantes.

### `record.rat.la.conf` modificado

    server {
        listen 80 default_server;
        listen [::]:80 default_server;

        # SSL configuration
        #
        # listen 443 ssl default_server;
        # listen [::]:443 ssl default_server;
        #
        # Note: You should disable gzip for SSL traffic.
        # See: https://bugs.debian.org/773332
        #
        # Read up on ssl_ciphers to ensure a secure configuration.
        # See: https://bugs.debian.org/765782
        #
        # Self signed certs generated by the ssl-cert package
        # Don't use them in a production server!
        #
        # include snippets/snakeoil.conf;

        root /var/www/record.rat.la;

        # Add index.php to the list if you are using PHP
        index index.php index.html index.htm index.nginx-debian.html;

        server_name record.rat.la;

        location / {
            # First attempt to serve request as file, then
            # as directory, then fall back to displaying a 404.
            try_files $uri $uri/ =404;
        }

        # pass PHP scripts to FastCGI server
        #
        location ~ \.php$ {
            include snippets/fastcgi-php.conf;

            # With php-fpm (or other unix sockets):
            fastcgi_pass unix:/run/php/php7.3-fpm.sock;
            # With php-cgi (or other tcp sockets):
            #fastcgi_pass 127.0.0.1:9000;
        }

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        location ~ /\.ht {
            deny all;
        }
    }


    # Virtual Host configuration for example.com
    #
    # You can move that to a different file under sites-available/ and symlink that
    # to sites-enabled/ to enable it.
    #
    #server {
    #   listen 80;
    #   listen [::]:80;
    #
    #   server_name example.com;
    #
    #   root /var/www/example.com;
    #   index index.html;
    #
    #   location / {
    #        try_files $uri $uri/ =404;
    #   }
    #}

Probamos la configuración y recargamos nginx.

    nginx -t
    systemctl reload nginx

## SSL con Lets Encrypt y Nginx en Debian 10

Instalaciones iniciales:

    apt install python3-acme python3-certbot python3-mock python3-openssl python3-pkg-resources python3-pyparsing python3-zope.interface
    apt install python3-certbot-nginx

Con el *Virtual Host* correctamente configurado en Nginx (como se indica
en el apartado anterior), ejecutamos el `certbot`

    certbot ---nginx -d record.rat.la

Respondemos a todas las preguntas a nuestro gusto y al final aparece
esto:

    IMPORTANT NOTES:
     - Congratulations! Your certificate and chain have been saved at:
       /etc/letsencrypt/live/record.rat.la/fullchain.pem
       Your key file has been saved at:
       /etc/letsencrypt/live/record.rat.la/privkey.pem
       Your cert will expire on 2020-12-18. To obtain a new or tweaked
       version of this certificate in the future, simply run certbot again
       with the "certonly" option. To non-interactively renew *all* of
       your certificates, run "certbot renew"
     - Your account credentials have been saved in your Certbot
       configuration directory at /etc/letsencrypt. You should make a
       secure backup of this folder now. This configuration directory will
       also contain certificates and private keys obtained by Certbot so
       making regular backups of this folder is ideal.
     - If you like Certbot, please consider supporting our work by:

       Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
       Donating to EFF:                    https://eff.org/donate-le

Si volvemos a `record.rat.la.conf` veremos que
`certbot` ha agregado unas lineas a nuestra configuración.

    listen [::]:443 ssl ipv6only=on; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/record.rat.la/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/record.rat.la/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

### SSL Certbot Auto-Renewal

Nos aseguramos de que cron se está ejecutando.

    systemctl enable cron
    systemctl start cron

Una vez instalado `certbot` se agrega automáticamente a
`cron` para ejecutarse dos veces al día. De todas formas
podemos probar que esto funciona correctamente ejecutando un simulacro
de renovación.

    certbot renew ---dry-run

## Script para actualizar la web desde mi PC personal

Para facilitar la actualización de la web, este script puede ser muy
útil.

    ssh user@server_ip_or_domain 'git -C /var/www/record.rat.la pull'

## Habilitar el header HTTP, *charset* UTF-8

Editamos el archivo `/etc/nginx/nginx.conf` y agregamos la
siguiente línea a la configuración del bloque `http`.

    charset UTF-8;

Guarda el archivo y recarga/reinicia el servicio.

    nginx -t
    systemctl reload nginx

## Bibliografía

-   [¿Cómo Instalar Linux, Nginx, MySQL, PHP (LEMP stack) in Ubuntu
    16.04?](https://www.digitalocean.com/community/tutorials/como-instalar-linux-nginx-mysql-php-lemp-stack-in-ubuntu-16-04-es)
-   [Update: Using Free Let's Encrypt SSL/TLS Certificates with
    NGINX](https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/)
-   [How To Secure Nginx with Let\'s Encrypt on Debian
    10](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-debian-10)
-   [Executing a git pull from a different
    directory](https://stackoverflow.com/questions/7622616/executing-a-git-pull-from-a-different-directory)
-   [Send Remote Commands Via
    SSH](https://malcontentcomics.com/systemsboy/2006/07/send-remote-commands-via-ssh.html)
-   [Make Browsers Cache Static Files On
    nginx](https://www.howtoforge.com/make-browsers-cache-static-files-on-nginx)
-   [How do I enable charset HTTP-header in
    Nginx?](https://www.cyberciti.biz/faq/nginx-set-http-content-type-response-header-to-charset-utf8/)