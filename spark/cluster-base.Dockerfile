ARG debian_buster_image_tag=8-jre-slim
FROM openjdk:${debian_buster_image_tag}

# -- Layer: OS + JDK8 + Python3.7 + mecab
ARG shared_workspace=/opt/workspace

RUN set -x \
    && mkdir -p ${shared_workspace} \
    && apt-get update -y \
    && apt-get install -y curl \
    && apt-get install -y python3 \
    && apt-get install -y python3-pip \
    && apt-get install -y autoconf \
    && pip3 install --upgrade pip setuptools wheel \
    && pip3 install pandas \
    && pip3 install JPype1 \
    && pip3 install konlpy \
    # pip3 install scikit-learn==0.22.1 && \
    # pip3 install tensorflow && \
    # pip3 install torch && \
    && ln -s /usr/bin/python3 /usr/bin/python \
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
  && curl -LO https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.1.1-20180720.tar.gz \
  && tar -zxvf mecab-ko-dic-2.1.1-20180720.tar.gz \
  && cd mecab-ko-dic-2.1.1-20180720 \
  && ./autogen.sh \
  # -- intel
  #./configure && \
  # -- m1
  && ./configure --build=aarch64-unknown-linux-gnu \
  && make && make install \
  # && cd ${shared_workspace} \
  # && rm mecab-0.996-ko-0.9.2.tar.gz mecab-ko-dic-2.1.1-20180720.tar.gz \
  # sh -c 'echo "dicdir=/usr/local/lib/mecab/dic/mecab-ko-dic" > /usr/local/etc/mecabrc' && \
  && cd / \
  && pip3 install mecab-python3 \
  && rm -rf /var/lib/apt/lists/* /tmp/*

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

# -- Runtime
VOLUME ${shared_workspace}
CMD ["bash"]
