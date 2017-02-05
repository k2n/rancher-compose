# Set base image.
FROM alpine:latest

MAINTAINER Kenji Nakamura <kenji@signifier.jp>

ARG RANCHER_COMPOSE_VERSION=${RANCHER_COMPOSE_VERSION}

# Install dependencies and rancher-compose
RUN apk add --quiet --no-cache jq curl git && \
	apk add --quiet --no-cache --virtual=build-dependencies ca-certificates && \
        curl -sSL "https://github.com/rancher/rancher-compose/releases/download/v${RANCHER_COMPOSE_VERSION}/rancher-compose-linux-amd64-v${RANCHER_COMPOSE_VERSION}.tar.gz" | tar -xz -C /usr/local/bin/ --strip-components=2 && \
        apk del --no-cache build-dependencies && \
	rm -rf /var/cache/*
RUN apk add --no-cache --virtual=goss-dependencies ca-certificates && \
        curl -s -f -L -o /usr/local/bin/await https://github.com/betalo-sweden/await/releases/download/v0.4.0/await-linux-amd64 && \
        apk del --no-cache goss-dependencies 

RUN	chmod +x /usr/local/bin/rancher-compose /usr/local/bin/await

# Set working directory
WORKDIR /workspace

# Executing defaults
CMD ["/bin/sh"]
