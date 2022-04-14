FROM ubuntu:18.04
LABEL maintainer="carl020958@korea.ac.kr"

ARG PYTHON_VERSION=3.8.10

RUN set -x \
    && apt-get update -y \
    && apt-get install -y curl \
    build-essential \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libreadline-dev \
    libffi-dev \
    libbz2-dev \
    libsqlite3-dev \
    && curl -fSL https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz -o /tmp/Python-${PYTHON_VERSION}.tgz \
    && tar -zxvf /tmp/Python-${PYTHON_VERSION}.tgz -C /tmp/ \
    && cd /tmp/Python-${PYTHON_VERSION} \
    && ./configure --enable-optimizations \
    && make altinstall \
    && ln -s /usr/local/bin/python$(echo $PYTHON_VERSION | cut -d "." -f 1-2) /usr/local/bin/python3 \
    && curl -fSL https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py \
    && python3 /tmp/get-pip.py \
    && rm -rf /tmp/Python* \
    && rm -rf /tmp/*.py \
    && rm -rf /var/lib/apt/lists/*

CMD ["bash"]