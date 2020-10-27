FROM alpine:latest

RUN apk update && \
    apk --no-cache add ca-certificates opendkim opendkim-utils postfix openssl && \
    mkdir /run/opendkim && mkdir /etc/opendkim/keys && chmod 777 /run/opendkim && \
    rm -rf /var/cache/apk/*

COPY opendkim.conf TrustedHosts /etc/opendkim/
COPY docker-entrypoint.sh /usr/local/bin/

ENV POSTFIX_HOSTNAME=
ENV OPENDKIM_SELECTOR=default

#STOPSIGNAL SIGKILL
EXPOSE 25
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/postfix", "start-fg"]
