FROM spark-base
LABEL maintainer="carl020958@korea.ac.kr"

# Airflow (JAVA_HOME / SSH)
COPY entrypoint.sh /entrypoint.sh
ARG working_directory=/usr/bin/spark-3.1.2-bin-hadoop3.2/conf
RUN set -x \
    && mv ${working_directory}/spark-env.sh.template ${working_directory}/spark-env.sh \
    && echo "JAVA_HOME=/usr/local/openjdk-8" >> /usr/bin/spark-3.1.2-bin-hadoop3.2/conf/spark-env.sh \
    && apt-get update -y \
    && apt-get install -y openssh-server \
    && sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config \
    && sed -i "s/#PasswordAuthentication yes/PasswordAuthentication yes/" /etc/ssh/sshd_config \
    && echo "root:1234" | chpasswd \
    && rm -rf /var/lib/apt/lists/* \
    && chmod +x /entrypoint.sh

# -- Runtime
ARG spark_master_web_ui=8080

EXPOSE ${spark_master_web_ui} ${SPARK_MASTER_PORT}

ENTRYPOINT ["sh", "/entrypoint.sh"]
CMD bin/spark-class org.apache.spark.deploy.master.Master >> logs/spark-master.out
