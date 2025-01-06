FROM alpine

RUN apk update && apk upgrade
RUN apk add nginx

RUN mkdir -p /etc/nginx/http.d
COPY ./config/default.conf /etc/nginx/http.d/default.conf

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]