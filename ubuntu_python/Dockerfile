FROM ubuntu:18.04
LABEL maintainer="carl020958@korea.ac.kr"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y software-properties-common \
  && add-apt-repository ppa:deadsnakes/ppa \
  && apt-get install -y python3.7 \
  && apt-get install -y python3.7-dev \
  && apt-get install -y python3-pip

RUN pip3 install --upgrade pip

CMD ["bash"]