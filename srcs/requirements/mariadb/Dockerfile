FROM alpine

RUN apk update && apk upgrade
RUN apk add mariadb mariadb-client --no-cache

COPY ./tools/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

COPY ./config/my.cnf /etc/my.cnf

RUN mkdir -p /opt/mariadb

EXPOSE 3306

ENTRYPOINT ["/tmp/setup.sh"]
