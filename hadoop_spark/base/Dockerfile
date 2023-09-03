FROM ubuntu:18.04
LABEL maintainer="zsu58@icloud.com"

RUN apt-get update -y \
    && apt-get install -y \
        openjdk-8-jdk \
        openssh-server \
        curl \
        gnupg2

RUN curl -fSL https://dist.apache.org/repos/dist/release/hadoop/common/KEYS -o /tmp/hadoop_keys \
    && gpg --import /tmp/hadoop_keys

# m1
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-arm64
# intel
# ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_VERSION=3.2.3
ARG HADOOP_URL=https://www.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz
RUN set -x \
    && curl -fSL "${HADOOP_URL}" -o /tmp/hadoop.tar.gz \
    && curl -fSL "${HADOOP_URL}.asc" -o /tmp/hadoop.tar.gz.asc \
    && gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop \
    && mkdir /opt/hadoop-$HADOOP_VERSION/logs \
    && mkdir /hadoop-data

ENV HADOOP_PREFIX=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1

ENV USER=root
ENV PATH $HADOOP_PREFIX/bin/:$PATH

ADD ./base/leveldbjni-all-1.8.jar /tmp/leveldbjni-all-1.8.jar
ADD ./base/entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
