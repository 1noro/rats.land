---
title: "Gitlab con Nginx reverse proxy"
mainTitle: "Gitlab con Nginx"
subtitle: "Reverse proxy"
date: 2021-03-07T11:07:00+01:00
draft: false
# tags: ["gitlab", "nginx", "reverse-proxy", "ssl", "letsencrypt", "certbot"]
tags: ["git", "nginx", "linux"]
summary: "Voy a documentar el proceso de instalación de Gitlab en una máquina virtual detrás de un Nginx reverse proxy."
displaySummary: false
---

Voy a documentar el proceso de instalación de Gitlab en una máquina
virtual detrás de un Nginx haciendo de _reverse proxy_.

## Descripción del escenario

{{< imgLandscape src="gitlab-nginx.webp" alt="Diagrama en el que me basaré para la explicación" >}}
Diagrama en el que me basaré para la explicación.
{{< /imgLandscape >}}

-   Certificado SSL con Let\'s Encrypt y certbot.
-   Escuchar en los puertos 80 (HTTP) y 443 (HTTPs) con una redirección
    automática desde el 80 al 443.
-   Acceso mediante SSH con clave pública y protegido con fail2ban.

## Configuración del router

En la sección de redirección de puertos (port forwarding) de nuestro
router creamos dos registros nuevos sobre el protocolo TCP.

-   El puerto 80 del router apuntará al puerto 80 de la máquina de Nginx
    (192.168.1.105), para las conexiones HTTP.
-   El puerto 443 del router apuntará al puerto 443 de la máquina de
    Nginx (192.168.1.105), para las conexiones HTTPs.
-   El puerto 22 del router apuntará al puerto 22 de la máquina de
    Gitlab (192.168.1.108), para las conexiones SSH.

## Configuración de Nginx

Nos situamos en la máquina que va a ejercer de reverse proxy con Nginx y creamos el archivo `/etc/nginx/sites-available/git.example.com.conf`.

    server {
        listen 80;
        listen [::]:80;
        server_name git.example.com;

        location / {
            proxy_pass "http://192.168.1.108/";
            proxy_redirect off;
            proxy_set_header Host $http_host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Forwarded-Protocol $scheme;
            proxy_set_header X-Url-Scheme $scheme;
        }
    }

Habilitamos el sitio.

    ln -s /etc/nginx/sites-available/git.example.com.conf /etc/nginx/sites-enabled/

Testeamos la sintaxis de la configuración de Nginx, y si todo va bien,
recargamos la configuración.

    nginx -t
    systemctl reload nginx

Con el Virtual Host correctamente configurado en Nginx, ejecutamos el
certbot.

    certbot ---nginx -d git.example.com

Durante el proceso de creación del certificado indicamos que queremos redireccionar el tráfico HTTP al HTTPs. Y a continuación se expone cómo quedará `/etc/nginx/sites-available/git.example.com.conf` después de ejecutar el certbot.

    server {
        server_name git.example.com;

        location / {
            proxy_pass "http://192.168.1.108/";
            proxy_redirect off;
            proxy_set_header Host $http_host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Forwarded-Protocol $scheme;
            proxy_set_header X-Url-Scheme $scheme;
        }

        listen [::]:443 ssl; # managed by Certbot
        listen 443 ssl; # managed by Certbot
        ssl_certificate /etc/letsencrypt/live/git.example.com/fullchain.pem; # managed by Certbot
        ssl_certificate_key /etc/letsencrypt/live/git.example.com/privkey.pem; # managed by Certbot
        include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
        ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
    }

    server {
        if ($host = git.example.com) {
            return 301 https://$host$request_uri;
        } # managed by Certbot

        listen 80;
        listen [::]:80;

        server_name git.example.com;
        return 404; # managed by Certbot
    }

## Configuración SSH

[Generamos en nuestro equipo una clave SSH](https://docs.github.com/es/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) y copiamos la clave a la máquina del Gitlab (192.168.1.108).

    ssh-copy-id -i ~/.ssh/id_rsa.pub user@192.168.1.108

Nos situamos en la máquina que va a ejecutar Gitlab (192.168.1.108) y editamos el archivo `/etc/ssh/sshd_config`. Después nos aseguramos de que las siguientes lineas tengan los valores mostrados.

    UsePAM yes
    PasswordAuthentication no

Y agregamos la siguiente línea al final.

    PermitRootLogin no

Guardamos y reiniciamos el servicio.

    sudo systemctl restart sshd

### Fail2ban

Instalamos el programa.

    sudo apt update
    sudo apt install fail2ban

Creamos el archivo `/etc/fail2ban/jail.local` y agregamos las
siguientes lineas.

    [DEFAULT]
    ignoreip = 127.0.0.1/8 192.168.1.0/24
    bantime = 10m
    maxretry = 5
    findtime = 1d

    [sshd]
    enabled = true

Guardamos y reiniciamos el servicio.

    sudo systemctl restart fail2ban

## Instalación y configuración de Gitlab

Nos situamos en la máquina que va a ejecutar Gitlab (192.168.1.108) e instalamos los paquetes necesarios. Luego agregamos el repositorio de Gitlab.

    sudo apt update
    sudo apt install curl openssh-server ca-certificates tzdata perl postfix

    curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash

    sudo EXTERNAL_URL="http://git.example.com" apt-get install gitlab-ce

**Nótese que el parámetro `EXTERNAL_URL` se define con `http` y no con `https`.** Posteriormente editamos el archivo `/etc/gitlab/gitlab.rb` y agregamos las siguientes lineas al final.

    nginx['listen_port'] = 80
    nginx['listen_https'] = false

    nginx['proxy_set_headers'] = {
        "X-Forwarded-Proto" => "http"
    }

    nginx['real_ip_trusted_addresses'] = [ '192.168.1.0/24' ]
    nginx['real_ip_header'] = 'X-Forwarded-For'
    nginx['real_ip_recursive'] = 'on'

Re-configuramos Gitlab.

    sudo gitlab-ctl reconfigure

Hay que esperar un rato a que se reconfigure, incluso después de que el comando haya finalizado. Una vez acabado este proceso ya podremos acceder a nuestro Gitlab a través de HTTPs para definir la contraseña del usuario `root`.

## Referencias

-   [How to Install and Configure Fail2ban on Ubuntu
    20.04](https://linuxize.com/post/install-configure-fail2ban-on-ubuntu-20-04/)
-   [Gitlab Official Linux package (recommended
    installation)](https://about.gitlab.com/install/#ubuntu)
-   [Gitlab Nginx
    settings](https://docs.gitlab.com/omnibus/settings/nginx.html)
