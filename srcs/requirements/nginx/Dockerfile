FROM alpine

RUN apk update && apk upgrade
RUN apk add nginx openssl

RUN mkdir -p /etc/nginx/http.d
COPY ./config/default.conf /etc/nginx/http.d/default.conf

COPY ./tools/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

ENTRYPOINT ["/tmp/setup.sh"]