FROM alpine:3.17

RUN apk --no-cache add bash ncurses

COPY ./src/visum.sh /

ENTRYPOINT [ "/entrpoint.sh", "-v" ]
