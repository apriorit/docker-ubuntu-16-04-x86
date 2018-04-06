# This docker file contains build environment
FROM i386/ubuntu:16.04
MAINTAINER bidnichenko <bidnichenko.alex@apriorit.com>

ENV DEBIAN_FRONTEND noninteractive
RUN export KERNEL_VERSION=$(uname -r)
ENV KERNEL_VERSION $KERNEL_VERSION

#uncomment all src repositories
RUN sed -i -- 's/#deb-src/deb-src/g' /etc/apt/sources.list && sed -i -- 's/# deb-src/deb-src/g' /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y \
&& apt-get install -y bison++:i386 unzip:i386 libssl-dev:i386 libprocps4-dev:i386 libxalan-c-dev:i386 libxerces-c-dev:i386 libnl-3-dev:i386 \
libcrypto++-dev:i386 libcrypto++9v5:i386 libpcre++-dev:i386 uuid-dev:i386 libsnappy-dev:i386 build-essential:i386 libboost-all-dev:i386 cmake:i386 maven:i386 libicu-dev:i386 \
zlib1g-dev:i386 liblog4cpp5-dev:i386 libncurses5-dev:i386 libselinux1-dev:i386 wget:i386 libsqlite3-dev:i386 google-mock:i386 libvirt-dev:i386 libmysqlclient-dev:i386 \
libjpeg-turbo8-dev:i386 libnuma-dev:i386 libxml2-dev:i386 qtbase5-dev:i386 qtdeclarative5-dev:i386 libgcrypt20-dev:i386 libglib2.0-dev:i386 libpixman-1-dev:i386 \
libhivex-dev:i386 libguestfs-dev:i386 libedit-dev:i386 libc6-dev-x32:i386 libelf-dev:i386 \
snapcraft libelf-dev git autoconf patchelf linux-headers-$KERNEL_VERSION \
&& apt-get build-dep -y qemu-kvm \
&& rm /var/lib/apt/lists/* -rf

#gRPC
RUN git clone --recursive --branch release-0_14_1 --single-branch https://github.com/grpc/grpc \
&& cd grpc && make HAS_SYSTEM_OPENSSL_NPN=false HAS_SYSTEM_OPENSSL_ALPN=false && make install prefix=/opt/grpc \
&& cd third_party/protobuf/ && make install prefix=/opt/grpc && rm /grpc -rf
