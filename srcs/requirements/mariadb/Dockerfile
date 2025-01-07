FROM alpine

RUN apk update && apk upgrade
RUN apk add mariadb mariadb-client --no-cache

COPY ./tools/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

COPY ./config/my.cnf /etc/my.cnf

COPY ./config/init_sql.sh /tmp/init_sql.sh
RUN chmod +x /tmp/init_sql.sh

RUN mkdir -p /opt/mariadb

ENTRYPOINT ["/tmp/setup.sh"]
