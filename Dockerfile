FROM ubuntu:latest 

ENV MLVPN_VERSION=2.3.5
ENV EV_VERSION=4.22
ENV LIBSODIUM_VERSION=1.0.8
ENV PCAP_VERSION=1.7.4
ENV INSTALLDIR=/mlvpn

RUN apt-get update
RUN apt-get install -y flex bison build-essential wget iproute2 net-tools iptables
RUN mkdir /mlvpn
RUN wget http://dist.schmorp.de/libev/Attic/libev-${EV_VERSION}.tar.gz
RUN wget https://github.com/jedisct1/libsodium/releases/download/1.0.8/libsodium-${LIBSODIUM_VERSION}.tar.gz
RUN wget http://www.tcpdump.org/release/libpcap-${PCAP_VERSION}.tar.gz
RUN wget https://github.com/zehome/MLVPN/releases/download/${MLVPN_VERSION}/mlvpn-${MLVPN_VERSION}.tar.gz
RUN tar xzf libev-${EV_VERSION}.tar.gz && rm libev-${EV_VERSION}.tar.gz
RUN tar xzf libsodium-${LIBSODIUM_VERSION}.tar.gz && rm libsodium-${LIBSODIUM_VERSION}.tar.gz
RUN tar xzf libpcap-${PCAP_VERSION}.tar.gz && rm libpcap-${PCAP_VERSION}.tar.gz
RUN tar xzf mlvpn-${MLVPN_VERSION}.tar.gz && rm mlvpn-${MLVPN_VERSION}.tar.gz
RUN cd && \
    cd /libev-${EV_VERSION} && \ 
    ./configure --enable-static --disable-shared  --prefix $INSTALLDIR/libev/ && \ 
    make && \ 
    make -j4 install
RUN cd && \
    cd /libsodium-${LIBSODIUM_VERSION} && \ 
    ./configure --enable-static --disable-shared  --prefix $INSTALLDIR/libsodium/ && \ 
    make && \ 
    make -j4 install
RUN cd && \
    cd /libpcap-${PCAP_VERSION} && \ 
    ./configure --enable-static --disable-shared  --prefix $INSTALLDIR/libpcap/ && \ 
    make && \ 
    make -j4 install
RUN cd && \
    cd /mlvpn-${MLVPN_VERSION} && \ 
    libpcap_LIBS="-L${INSTALLDIR}/libpcap/lib -lpcap" libpcap_CFLAGS="-I${INSTALLDIR}/libpcap/include" libsodium_LIBS="-L${INSTALLDIR}/libsodium/lib -lsodium" libsodium_CFLAGS=-I${INSTALLDIR}/libsodium/include libev_LIBS="-L${INSTALLDIR}/libev/lib -lev" libev_CFLAGS=-I${INSTALLDIR}/libev/include ./configure --enable-filters LDFLAGS="-Wl,-Bdynamic" --prefix=${INSTALLDIR}/mlvpn/ --enable-static --disable-shared  && \ 
    make && \ 
    make install

RUN mkdir /root/mlvpn
COPY . /root/mlvpn

CMD ["/bin/bash", "/root/mlvpn/launch-bonder.sh"]
