FROM gliderlabs/alpine:3.1
MAINTAINER cristian.arroyo@vivaserver.com

RUN apk add --update redis
RUN rm -rf /var/cache/apk/*

# restore the DB from a previous backup or use in a new image starting from this one
# COPY dump.2013-08-19.rdb /var/lib/redis/dump.rdb

RUN sed 's/^daemonize yes/daemonize no/'              -i /etc/redis.conf
RUN sed 's/^bind 127.0.0.1/bind 0.0.0.0/'             -i /etc/redis.conf
RUN sed 's/^# unixsocket /unixsocket /'               -i /etc/redis.conf
RUN sed 's/^# unixsocketperm 700/unixsocketperm 777/' -i /etc/redis.conf
RUN sed '/^logfile/d'                                 -i /etc/redis.conf

CMD ["/usr/bin/redis-server","/etc/redis.conf"]

EXPOSE 6379
