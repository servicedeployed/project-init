FROM debian:stretch-slim

RUN apt update
RUN apt install -y git curl

VOLUME [ "/project" ]

WORKDIR /init

COPY download.sh .

ENTRYPOINT [ "./download.sh" ]