FROM alpine:3.18

LABEL description "Rainloop is a simple, modern & fast web-based client" \
      maintainer="Codestack <shis@shis95.vip>"

ARG GPG_FINGERPRINT="3B79 7ECE 694F 3B7B 70F3  11A4 ED7C 49D9 87DA 4591"

ENV UID=100 GID=1000 UPLOAD_MAX_SIZE=25M LOG_TO_STDOUT=false MEMORY_LIMIT=128M

RUN echo "https://nl.alpinelinux.org/alpine/v3.18/community" >> /etc/apk/repositories \
 && apk -U upgrade \
 && apk add -t build-dependencies \
    gnupg \
    openssl \
    wget \
 && apk add \
    ca-certificates \
    nginx \
    s6 \
    su-exec \
    php82-fpm \
    php82-curl \
    php82-iconv \
    php82-xml \
    php82-dom \
    php82-openssl \
    php82-json \
    php82-zlib \
    php82-pdo_pgsql \
    php82-pdo_mysql \
    php82-pdo_sqlite \
    php82-sqlite3 \
    php82-ldap \
    php82-simplexml \
 && cd /tmp \
 && wget -q https://github.com/RainLoop/rainloop-webmail/releases/download/v1.17.0/rainloop-legacy-1.17.0.zip -O rainloop-latest.zip \
 && wget -q https://github.com/RainLoop/rainloop-webmail/releases/download/v1.17.0/rainloop-legacy-1.17.0.zip.asc  -O rainloop-latest.zip.asc \
 && wget -q https://www.rainloop.net/repository/RainLoop.asc \
 && gpg --import RainLoop.asc \
 && FINGERPRINT="$(LANG=C gpg --verify rainloop-latest.zip.asc rainloop-latest.zip 2>&1 \
  | sed -n "s#Primary key fingerprint: \(.*\)#\1#p")" \
 && if [ -z "${FINGERPRINT}" ]; then echo "ERROR: Invalid GPG signature!" && exit 1; fi \
 && if [ "${FINGERPRINT}" != "${GPG_FINGERPRINT}" ]; then echo "ERROR: Wrong GPG fingerprint!" && exit 1; fi \
 && mkdir /rainloop && unzip -q /tmp/rainloop-latest.zip -d /rainloop \
 && find /rainloop -type d -exec chmod 755 {} \; \
 && find /rainloop -type f -exec chmod 644 {} \; \
 && apk del build-dependencies \
 && rm -rf /tmp/* /var/cache/apk/* /root/.gnupg

COPY rootfs /
RUN chmod +x /usr/local/bin/run.sh /services/*/run /services/.s6-svscan/*
VOLUME /rainloop/data
EXPOSE 8888
CMD ["run.sh"]
