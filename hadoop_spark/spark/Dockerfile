FROM base-python
LABEL maintainer="carl020958@korea.ac.kr"

ENV SPARK_VERSION=3.1.2
ARG SPARK_HADOOP_VERSION=3.2
ENV SPARK_HOME=/opt/spark
ENV PYSPARK_PYTHON=python3

RUN set -x \
    && curl -fSL https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}.tgz -o /tmp/spark.tgz \
    && tar -zxvf /tmp/spark.tgz -C /opt/ \
    && mv /opt/spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION} ${SPARK_HOME} \
    && rm /tmp/spark.tgz \
    && mv ${SPARK_HOME}/conf/spark-defaults.conf.template ${SPARK_HOME}/conf/spark-defaults.conf \
    && mkdir ${shared_workspace}/src

# Airflow (JAVA_HOME / SSH)
COPY ./spark/run.sh /run.sh
RUN set -x \
    && mv ${SPARK_HOME}/conf/spark-env.sh.template ${SPARK_HOME}/conf/spark-env.sh \
    && echo "JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-arm64" >> ${SPARK_HOME}/conf/spark-env.sh \
    && echo "HADOOP_CONF_DIR=/etc/hadoop" >> ${SPARK_HOME}/conf/spark-env.sh \
    && apt-get update -y \
    && apt-get install -y openssh-server \
    && sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config \
    && sed -i "s/#PasswordAuthentication yes/PasswordAuthentication yes/" /etc/ssh/sshd_config \
    && echo "root:1234" | chpasswd \
    && rm -rf /var/lib/apt/lists/* \
    && chmod a+x /run.sh

WORKDIR ${SPARK_HOME}

CMD ["/run.sh", "bash"]