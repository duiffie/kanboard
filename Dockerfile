FROM alpine:3.16

VOLUME /var/www/app/data
VOLUME /var/www/app/plugins
VOLUME /etc/nginx/ssl

EXPOSE 80 443

ARG VERSION

RUN apk --no-cache --update add \
    tzdata openssl unzip nginx bash ca-certificates s6 curl ssmtp mailx php81 php81-phar php81-curl \
    php81-fpm php81-json php81-zlib php81-xml php81-dom php81-ctype php81-opcache php81-zip php81-iconv \
    php81-pdo php81-pdo_mysql php81-pdo_sqlite php81-pdo_pgsql php81-mbstring php81-session php81-bcmath \
    php81-gd php81-openssl php81-sockets php81-posix php81-ldap php81-simplexml && \
    rm -rf /var/www/localhost && \
    rm -f /etc/php81/php-fpm.d/www.conf && \
    ln -s /usr/bin/php81 /usr/bin/php

ADD . /var/www/app
ADD docker/ /

RUN rm -rf /var/www/app/docker && echo $VERSION > /var/www/app/app/version.txt

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD []
