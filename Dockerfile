FROM ubuntu:latest 

ENV MLVPN_VERSION=2.3.5 
ENV EV_VERSION=4.33 
ENV LIBSODIUM_VERSION=1.0.18 
ENV PCAP_VERSION=1.9.1 
ENV INSTALLDIR=/mlvpn

RUN apt-get update && \ 
    apt-get install -y flex bison build-essential wget && \
    mkdir /mlvpn && \ 
    tar xzf libev-${EV_VERSION}.tar.gz && rm libev-${EV_VERSION}.tar.gz && \ 
    tar xzf libsodium-${LIBSODIUM_VERSION}.tar.gz && rm libsodium-${LIBSODIUM_VERSION}.tar.gz && \ 
    tar xzf libpcap-${PCAP_VERSION}.tar.gz && rm libpcap-${PCAP_VERSION}.tar.gz && \ 
    tar xzf mlvpn-${MLVPN_VERSION}.tar.gz && rm mlvpn-${MLVPN_VERSION}.tar.gz && \ 
    cd && \
    cd /libev-${EV_VERSION} && \ 
    ./configure --enable-static --disable-shared  --prefix $INSTALLDIR/libev/ && \ 
    make && \ 
    make -j4 install && \ 
    cd && \
    cd /libsodium-${LIBSODIUM_VERSION} && \ 
    ./configure --enable-static --disable-shared  --prefix $INSTALLDIR/libsodium/ && \ 
    make && \ 
    make -j4 install && \ 
    cd && \
    cd /libpcap-${PCAP_VERSION} && \ 
    ./configure --enable-static --disable-shared  --prefix $INSTALLDIR/libpcap/ && \ 
    make && \ 
    make -j4 install && \ 
    cd && \
    cd /mlvpn-${MLVPN_VERSION} && \ 
    libpcap_LIBS="-L${INSTALLDIR}/libpcap/lib -lpcap" libpcap_CFLAGS="-I${INSTALLDIR}/libpcap/include" libsodium_LIBS="-L${INSTALLDIR}/libsodium/lib -lsodium" libsodium_CFLAGS=-I${INSTALLDIR}/libsodium/include libev_LIBS="-L${INSTALLDIR}/libev/lib -lev" libev_CFLAGS=-I${INSTALLDIR}/libev/include ./configure --enable-filters LDFLAGS="-Wl,-Bdynamic" --prefix=${INSTALLDIR}/mlvpn/ --enable-static --disable-shared  && \ 
    make && \ 
    make install
#CMD ["/mlvpn/mlvpn/sbin/mlvpn"]