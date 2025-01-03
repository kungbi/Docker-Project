FROM alpine

RUN apk update && apk upgrade
RUN apk add nginx

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]