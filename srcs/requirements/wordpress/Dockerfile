FROM alpine:3.20.6

RUN apk update && apk upgrade


RUN apk add php php-fpm php-mysqli \
	php-json php-curl php-exif php-zip php-phar \
	php-opcache php-dom php-session curl wget

COPY ./tools/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar
RUN cp wp-cli.phar /usr/bin/wp

ENTRYPOINT [ "/tmp/setup.sh" ]
