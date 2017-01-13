# Set base image.
FROM alpine:latest

MAINTAINER Kenji Nakamura <kenji@signifier.jp>

ARG RANCHER_COMPOSE_VERSION=${RANCHER_COMPOSE_VERSION}

# Install dependencies and rancher-compose
RUN apk add --quiet --no-cache ca-certificates && \
	apk add --quiet --no-cache --virtual build-dependencies curl && \
	curl -sSL "https://github.com/rancher/rancher-compose/releases/download/v${RANCHER_COMPOSE_VERSION}/rancher-compose-linux-amd64-v${RANCHER_COMPOSE_VERSION}.tar.gz" | tar -xz -C /usr/local/bin/ --strip-components=2 
RUN	chmod +x /usr/local/bin/rancher-compose && \
#	apk del --no-cache build-dependencies && \
	rm -rf /var/cache/*

# Set working directory
WORKDIR /workspace

# Executing defaults
CMD ["/bin/sh"]
