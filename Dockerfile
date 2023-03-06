FROM alpine:3.17

RUN apk --no-cache add bash ncurses
ENV TERM=xterm

COPY ./src/entrypoint.sh /srv/app/

ENTRYPOINT [ "/srv/app/entrypoint.sh", "-v" ]
