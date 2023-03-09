FROM debian:stretch-slim

RUN apt update
RUN apt install -y git curl

VOLUME [ "/project" ]

WORKDIR /init

COPY download.sh .
RUN chmod +x download.sh

ENV PROJECT_DIR=/project
ENV URL=""

ENTRYPOINT [ "./download.sh" ]