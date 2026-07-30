---
title: "Configurar drivers de Nvidia en Arch Linux"
mainTitle: "Configurar drivers de Nvidia"
subtitle: "En Arch Linux"
date: 2021-03-29T22:56:00+01:00
draft: false
# tags: ["arch", "linux", "nvidia"]
tags: ["linux"]
summary: "Configurar los drivers de Nvidia en Arch Linux con Gnome y Xorg."
displaySummary: false
---

Yo antes solo utilizaba mi fabulosa tarjeta gráfica integrada de **Intel
Graphics 2500**, pero durante el confinamiento estuve jugando a algún
que otro videojuego y vi que se quedaba algo corta en ciertos aspectos,
por lo que decidí comprarme una tarjeta gráfica.

Me compré una **Nvidia GTX 1070**, por lo que enfocaré este artículo
hacia mi modelo. Por suerte, mi configuración habitual es bastante
estándar, por lo que puede que le sirva a más de uno. Uso el núcleo de
**Linux** por defecto y **Gnome** sobre **Xorg** en el escritorio, como
buen amante del *default* que soy. En [este apartado de la Arch
Wiki](https://wiki.archlinux.org/index.php/NVIDIA#Installation) podrás
confirmar si tu gráfica se ajusta a estas instrucciones o no.

Antes de comenzar a explicar debo informar que en este artículo no vas a encontrar una mejor solución que [en la Arch Wiki](https://wiki.archlinux.org/index.php/NVIDIA). Escribo esto para que yó, que ya me he leído la wiki, y la he adaptado a mi situación, no tenga que volver a hacerlo la próxima vez que instale mi PC. Si encuentras algún problema durante este proceso puedes consultarme, pero personalmente te recomiendo que consultes la wiki. Estoy seguro de que tu solución específica se encuentra ahí.

## Eliminar la instalación previa de Intel

Como parto de mi situación real, veo útil explicar los pasos que seguí
durante la desinstalación de los drivers de **Intel** que estaban
configurados previamente en mi PC.

Editamos el archivo `/etc/mkinitcpio.conf` y eliminamos del
array `MODULES` el módulo `i915`. Como yo no tenía ningún modulo más,
previamente mi array quedaría de la siguiente manera.

    MODULES=()

Y ejecutamos el `mkinitcpio`.

    sudo mkinitcpio -p linux

Configuramos el **GRUB**, para que no cargue el módulo de *kernel* que
acabamos de quitar, editando el archivo `/etc/default/grub`.

Eliminamos el parámetro `i915.enable_guc=2` de la línea
`GRUB_CMDLINE_LINUX_DEFAULT`. Quedando, en mi caso, de la siguiente
forma.

    GRUB_CMDLINE_LINUX_DEFAULT="loglevel=4 nowatchdog"

Y volvemos a generar la configuración del **GRUB**.

    sudo grub-mkconfig -o /boot/grub/grub.cfg

Borramos las configuraciones de Intel.

    sudo rm /etc/X11/xorg.conf.d/20-intel.conf
    rm ~/.drirc

Ponemos en la lista negra los módulos de Intel.

    sudo echo 'install i915 /bin/false' >> /etc/modprobe.d/blacklist.conf
    sudo echo 'install intel_agp /bin/false' >> /etc/modprobe.d/blacklist.conf

Borramos los drivers de Intel.

    sudo pacman -Rns xf86-video-intel

## Instalar y configurar los drivers de Nvidia

Instalamos los controladores y utilidades extra de Nvidia, a ser posible **en este mismo orden**.

    sudo pacman -S nvidia-utils
    sudo pacman -S nvidia
    sudo pacman -S lib32-nvidia-utils
    sudo pacman -S nvidia-settings

Generamos una configuración automática.

    sudo nvidia-xconfig

Revisamos `/etc/xorg.conf` para ver si nos convencen los
parámetros auto-generados, y **comentamos** la siguiente línea si está
presente.

    # Load        "dri"

Agregamos los siguientes módulos al kernel editando el array `MODULES`
del archivo `/etc/mkinitcpio.conf`.

    MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)

Y ejecutamos el `mkinitcpio`.

    sudo mkinitcpio -p linux

Definimos el parámetro `nvidia-drm.modeset=1` de arranque del kernel en
la línea `GRUB_CMDLINE_LINUX_DEFAULT` de la configuración del **GRUB**,
editando el archivo `/etc/default/grub`.

El resultado sería el siguiente.

    GRUB_CMDLINE_LINUX_DEFAULT="loglevel=4 nowatchdog nvidia-drm.modeset=1"

Y volvemos a generar la configuración del **GRUB**.

    sudo grub-mkconfig -o /boot/grub/grub.cfg

Ahora solo queda **reiniciar** la máquina para que se aplique
la nueva configuración. Recuerda cambiar el cable de la pantalla y
conectarlo a la gráfica.
