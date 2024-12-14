FROM jupyter/base-notebook:latest
LABEL maintainer="zsu58@icloud.com"

USER root

RUN apt-get update -y \
    && apt-get install -y \
    openjdk-8-jdk \
    curl

USER jovyan
WORKDIR /home/jovyan/work
RUN curl -Lo coursier https://git.io/coursier-cli \
    && chmod +x coursier \
    # change scala version if needed
    && ./coursier launch almond --scala 3.3.3 -- --install \
    && rm coursier
