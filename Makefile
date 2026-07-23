# =============================================================================
#  rats.land — Makefile
#
#  Toda la web se compila DENTRO de un contenedor Docker con una versión de
#  Hugo fijada (ver HUGO_VERSION). Así el build es reproducible y no hace falta
#  instalar Hugo en la máquina: sólo se necesita Docker.
#
#  Uso rápido:
#      make            # muestra esta ayuda
#      make server     # servidor de desarrollo con recarga en vivo
#      make build      # compila el sitio estático en ./public
#
#  Todas las variables se pueden sobreescribir, p. ej.:
#      make server PORT=8080
#      make build HUGO_VERSION=0.165.0
# =============================================================================

# ---- Configuración (sobreescribible desde la línea de comandos) -------------
HUGO_VERSION ?= 0.164.0
IMAGE        ?= ratsland/hugo:$(HUGO_VERSION)
PORT         ?= 1313

# ---- Valores derivados (no tocar) -------------------------------------------
ROOT := $(shell pwd)
UID  := $(shell id -u)
GID  := $(shell id -g)
# `--tty` sólo si hay terminal interactiva (evita fallos en CI / pipes).
TTY  := $(shell [ -t 0 ] && echo --tty)

# Ejecuta el binario `hugo` dentro del contenedor con el repo montado en /src.
# --user conserva la propiedad de los ficheros generados (public/, resources/).
# --entrypoint hugo permite pasar los subcomandos directamente.
DOCKER_RUN = docker run --rm --interactive $(TTY) \
	--user $(UID):$(GID) \
	--volume "$(ROOT):/src" \
	--workdir /src \
	--env HOME=/tmp \
	--entrypoint hugo \
	$(IMAGE)

# Igual que DOCKER_RUN pero publicando el puerto para el servidor de desarrollo.
DOCKER_SERVE = docker run --rm --interactive $(TTY) \
	--user $(UID):$(GID) \
	--volume "$(ROOT):/src" \
	--workdir /src \
	--env HOME=/tmp \
	--publish $(PORT):$(PORT) \
	--entrypoint hugo \
	$(IMAGE)

.DEFAULT_GOAL := help
.PHONY: help image build server serve drafts new clean version config deploy shell pull

# -----------------------------------------------------------------------------
help: ## Muestra esta ayuda
	@echo ""
	@echo "  rats.land — Hugo $(HUGO_VERSION) (dentro de Docker)"
	@echo ""
	@echo "  Targets disponibles:"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "} {printf "    \033[36m%-10s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "  Variables: HUGO_VERSION=$(HUGO_VERSION)  PORT=$(PORT)  IMAGE=$(IMAGE)"
	@echo ""

image: ## Construye la imagen Docker con la versión de Hugo fijada (si falta)
	@docker image inspect $(IMAGE) >/dev/null 2>&1 || { \
		echo ">> Construyendo $(IMAGE) ..."; \
		docker build --build-arg HUGO_VERSION=$(HUGO_VERSION) -t $(IMAGE) infra; \
	}

build: image ## Compila el sitio estático de producción en ./public
	$(DOCKER_RUN) --gc --minify --cleanDestinationDir
	@echo ">> Sitio generado en ./public"

server: image ## Servidor de desarrollo con recarga en vivo (puerto PORT, por defecto 1313)
	$(DOCKER_SERVE) server --bind 0.0.0.0 --port $(PORT)

serve: server ## Alias de `server`

drafts: image ## Como `server` pero incluye borradores y contenido futuro
	$(DOCKER_SERVE) server --bind 0.0.0.0 --port $(PORT) \
		--buildDrafts --buildFuture --disableFastRender

new: image ## Crea contenido nuevo: make new CONTENT=post/mi-post.md
	@test -n "$(CONTENT)" || { echo "Uso: make new CONTENT=post/mi-post.md"; exit 1; }
	$(DOCKER_RUN) new content $(CONTENT)

version: image ## Muestra la versión de Hugo usada por el contenedor
	$(DOCKER_RUN) version

config: image ## Vuelca la configuración efectiva de Hugo (útil para depurar)
	$(DOCKER_RUN) config

deploy: build ## Publica en S3/CloudFront (requiere credenciales AWS en el entorno)
	docker run --rm --interactive $(TTY) \
		--user $(UID):$(GID) \
		--volume "$(ROOT):/src" \
		--workdir /src \
		--env HOME=/tmp \
		--env AWS_ACCESS_KEY_ID \
		--env AWS_SECRET_ACCESS_KEY \
		--env AWS_SESSION_TOKEN \
		--env AWS_DEFAULT_REGION \
		--entrypoint hugo \
		$(IMAGE) deploy

shell: image ## Abre una shell interactiva dentro del contenedor
	docker run --rm --interactive --tty \
		--user $(UID):$(GID) \
		--volume "$(ROOT):/src" \
		--workdir /src \
		--env HOME=/tmp \
		--entrypoint sh \
		$(IMAGE)

clean: ## Borra los artefactos generados (public/ y resources/)
	rm -rf public resources
	@echo ">> Limpiado public/ y resources/"

pull: ## Descarga la imagen base de hugomods para la versión fijada
	docker pull hugomods/hugo:git-$(HUGO_VERSION)
