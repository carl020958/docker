FROM carl020958/ubuntu-python:18.04-3.8.10
LABEL maintainer="carl020958@korea.ac.kr"

RUN set -x \
    && apt-get update -y \
    && apt-get install -y openssh-server \
    && mkdir /var/run/sshd \
    && sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config \
    && sed -i "s/#PasswordAuthentication yes/PasswordAuthentication yes/" /etc/ssh/sshd_config \
    && echo "root:1234" | chpasswd \
    && rm -rf /var/lib/apt/lists/*

CMD ["/usr/sbin/sshd", "-D"]
