FROM ubuntu:18.04
LABEL maintainer="carl020958@korea.ac.kr"

ENV DEBIAN_FRONTEND=noninteractive
ARG PYTHON_VERSION=3.8.10
ARG PYTHON_VERSION_PREFIX="$(echo $PYTHON_VERSION | cut -d "." -f 1-2)"

RUN set -x \
    && apt-get update -y \
    && apt-get install -y curl \
    && apt-get install -y build-essential \
    && apt-get install -y zlib1g-dev \
    && apt-get install -y libncurses5-dev \
    && apt-get install -y libgdbm-dev \
    && apt-get install -y libnss3-dev \
    && apt-get install -y libssl-dev \
    && apt-get install -y libreadline-dev \
    && apt-get install -y libffi-dev \
    && apt-get install -y libbz2-dev \
    && apt-get install libsqlite3-dev \
    && cd tmp \
    && curl -O https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar -zxvf Python-${PYTHON_VERSION}.tgz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure --enable-optimizations \
    && make altinstall \
    && ln -s /usr/local/bin/python${PYTHON_VERSION_PREFIX} /usr/local/bin/python3 \
    && curl -O https://bootstrap.pypa.io/get-pip.py \
    && python3 get-pip.py \
    && pip3 install --upgrade pip \
    && rm -rf * \
    && rm -rf /var/lib/apt/lists/*

CMD ["bash"]