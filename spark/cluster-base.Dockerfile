ARG debian_buster_image_tag=8-jre-slim
FROM openjdk:${debian_buster_image_tag}
LABEL maintainer="carl020958@korea.ac.kr"

# -- Layer: OS + JDK8 + Python3.8.10 + mecab
ARG shared_workspace=/opt/workspace

ARG PYTHON_VERSION=3.8.10
ARG PYTHON_VERSION_PREFIX="$(echo $PYTHON_VERSION | cut -d "." -f 1-2)"

RUN set -x \
    && mkdir -p ${shared_workspace} \
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
    && apt-get install -y autoconf \
    && cd ${shared_workspace} \
    && curl -O https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar -zxvf Python-${PYTHON_VERSION}.tgz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure --enable-optimizations \
    && make altinstall \
    && ln -s /usr/local/bin/python%{PYTHON_VERSION_PREFIX} /usr/local/bin/python3

RUN set -x \
    && cd ${shared_workspace} \
    && curl -O https://bootstrap.pypa.io/get-pip.py \
    && python3 get-pip.py \
    && rm -rf ${shared_workspace}/* \
    && rm -rf /var/lib/apt/lists/*

# mecab
RUN set -x \
  && cd ${shared_workspace} \
  && curl -LO https://bitbucket.org/eunjeon/mecab-ko/downloads/mecab-0.996-ko-0.9.2.tar.gz \
  && tar -zxvf mecab-0.996-ko-0.9.2.tar.gz \
  && cd mecab-0.996-ko-0.9.2 \
  # -- intel
  #./configure && \
  # -- m1
  && ./configure --build=aarch64-unknown-linux-gnu \
  && make && make check && make install && ldconfig \
# mecab-ko-dic
  && cd ${shared_workspace} \
  && curl -LO https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.1.1-20180720.tar.gz \
  && tar -zxvf mecab-ko-dic-2.1.1-20180720.tar.gz \
  && cd mecab-ko-dic-2.1.1-20180720 \
  && ./autogen.sh \
  # -- intel
  #./configure && \
  # -- m1
  && ./configure --build=aarch64-unknown-linux-gnu \
  && make && make install \
  && cd ${shared_workspace} \
  && rm mecab-0.996-ko-0.9.2.tar.gz mecab-ko-dic-2.1.1-20180720.tar.gz
  # sh -c 'echo "dicdir=/usr/local/lib/mecab/dic/mecab-ko-dic" > /usr/local/etc/mecabrc' && \

# add jars
RUN set -x \
  && cd /opt/workspace \
  && mkdir jars \
  && cd jars \
  && curl -LO https://repo1.maven.org/maven2/org/mongodb/spark/mongo-spark-connector_2.12/3.0.1/mongo-spark-connector_2.12-3.0.1.jar \
  && curl -LO https://repo1.maven.org/maven2/org/mongodb/mongodb-driver-core/4.0.5/mongodb-driver-core-4.0.5.jar \
  && curl -LO https://repo1.maven.org/maven2/org/mongodb/mongodb-driver-sync/4.0.5/mongodb-driver-sync-4.0.5.jar \
  && curl -LO https://repo1.maven.org/maven2/org/mongodb/bson/4.0.5/bson-4.0.5.jar \
  && curl -LO https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.21/mysql-connector-java-8.0.21.jar

RUN set -x \
    && pip install --upgrade pip setuptools wheel \
    && pip install pandas \
    # m1
    && pip install tensorflow==2.6.0 -f https://tf.kmtea.eu/whl/stable.html \
    # intel
    # && pip install tensorflow==2.6.0 \
    && pip install scipy \
    && pip install Cython \
    && pip install scikit-learn==0.22.1  \
    && pip install torch  \
    && pip install JPype1 \
    && pip install konlpy \
    && pip install mecab-python3 \
    # && pip install kss \
    && pip uninstall -y keras==2.8.0

# -- Runtime
VOLUME ${shared_workspace}
CMD ["bash"]
