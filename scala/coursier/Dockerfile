FROM ubuntu:22.04
LABEL maintainer="zsu58@icloud.com"

USER root

# RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update -y \
    && apt-get install -y \
    openjdk-11-jdk \
    curl

RUN curl -LO https://github.com/coursier/launchers/raw/master/cs-aarch64-pc-linux.gz \
    && gzip -d cs-aarch64-pc-linux.gz \
    && chmod +x cs-aarch64-pc-linux \
    && ./cs-aarch64-pc-linux setup -y

ENV PATH="$PATH:~/.local/share/coursier/bin"

RUN mkdir -p /root/dev

# RUN cs install giter8
