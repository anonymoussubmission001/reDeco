FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y wget git gcc

RUN wget -P /tmp https://dl.google.com/go/go1.19.1.linux-amd64.tar.gz

RUN tar -C /usr/local -xzf /tmp/go1.19.1.linux-amd64.tar.gz
RUN rm /tmp/go1.19.1.linux-amd64.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

WORKDIR /root
RUN apt-get update && apt-get install -y \
  build-essential \
  cmake \
  git \
  libssl-dev \
  sudo \
  wget \
  python3 \
  vim \
  libgmp3-dev \
  libprocps-dev \
  python3-markdown \
  libssl-dev \
  openjdk-17-jdk \
  junit4 \
  python3-markdown\
  libboost-program-options-dev \
  pkg-config
RUN mkdir -p ./reDeco
ADD jsnark/ ./reDeco/jsnark
ADD 2pc/ ./reDeco/2pc
ADD app/ ./reDeco/app
ADD src/ ./reDeco/src
ADD go.mod ./reDeco/
ADD README.md ./reDeco/
ADD install.sh .
ADD config.yml ./reDeco

WORKDIR /root/reDeco
RUN go mod tidy
WORKDIR /root

RUN ["/bin/bash", "install.sh"]
CMD ["/bin/bash"]
