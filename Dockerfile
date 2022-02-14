FROM casjaysdev/php:latest

ARG BUILD_DATE="$(date +'%Y-%m-%d %H:%M')" 

LABEL \
  org.label-schema.name="nginx" \
  org.label-schema.description="nginx webserver with php" \
  org.label-schema.url="https://github.com/casjaysdev/ympd" \
  org.label-schema.vcs-url="https://github.com/casjaysdev/ympd" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.version=$BUILD_DATE \
  org.label-schema.vcs-ref=$BUILD_DATE \
  org.label-schema.license="MIT" \
  org.label-schema.vcs-type="Git" \
  org.label-schema.schema-version="1.0" \
  org.label-schema.vendor="CasjaysDev" \
  maintainer="CasjaysDev <docker-admin@casjaysdev.com>" 

ENV PHP_SERVER=nginx
ENV SHELL /bin/bash

RUN apk -U upgrade && \
  apk add --no-cache \
  nginx && \
  mkdir -p /config /data

COPY ./config/. /etc/
COPY ./data/. /data/

WORKDIR /data/htdocs
EXPOSE 14433

VOLUME [ "/data", "/config" ]

HEALTHCHECK CMD [ "/usr/local/bin/entrypoint-nginx.sh" ]
ENTRYPOINT [ "/usr/local/bin/entrypoint-nginx.sh" ]
