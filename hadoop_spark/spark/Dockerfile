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

WORKDIR ${SPARK_HOME}

CMD ["bash"]