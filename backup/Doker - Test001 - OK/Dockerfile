FROM ubuntu:latest 

ENV MLVPN_VERSION=2.3.5 
ENV EV_VERSION=4.33 
ENV LIBSODIUM_VERSION=1.0.18 
ENV PCAP_VERSION=1.9.1 
ENV INSTALLDIR=/mlvpn

RUN apt-get update && \ 
    apt-get install -y flex bison build-essential wget apt-utils && \ 
    apt-get install -y --no-install-recommends apt-utils && \
    cd && \
    wget http://dist.schmorp.de/libev/Attic/libev-${EV_VERSION}.tar.gz && \
    wget https://github.com/jedisct1/libsodium/releases/download/1.0.18-RELEASE/libsodium-${LIBSODIUM_VERSION}.tar.gz && \
    wget http://www.tcpdump.org/release/libpcap-${PCAP_VERSION}.tar.gz && \ 
    wget https://github.com/zehome/MLVPN/releases/download/${MLVPN_VERSION}/mlvpn-${MLVPN_VERSION}.tar.gz  && \ 
    cd && \ 
    tar xzf libev-${EV_VERSION}.tar.gz && rm libev-${EV_VERSION}.tar.gz && \ 
    tar xzf libsodium-${LIBSODIUM_VERSION}.tar.gz && rm libsodium-${LIBSODIUM_VERSION}.tar.gz && \ 
    tar xzf libpcap-${PCAP_VERSION}.tar.gz && rm libpcap-${PCAP_VERSION}.tar.gz && \ 
    tar xzf mlvpn-${MLVPN_VERSION}.tar.gz && rm mlvpn-${MLVPN_VERSION}.tar.gz && \ 
    pwd && \
    ls && \
    cd /root/libev-${EV_VERSION} && \ 
    ./configure --enable-static --disable-shared  --prefix $INSTALLDIR/libev/ && \ 
    make && \ 
    make -j4 install && \ 
    cd && \
    cd /root/libsodium-${LIBSODIUM_VERSION} && \ 
    ./configure --enable-static --disable-shared  --prefix $INSTALLDIR/libsodium/ && \ 
    make && \ 
    make -j4 install && \ 
    cd && \
    cd /root/libpcap-${PCAP_VERSION} && \ 
    ./configure --enable-static --disable-shared  --prefix $INSTALLDIR/libpcap/ && \ 
    make && \ 
    make -j4 install && \ 
    cd && \
    cd /root/mlvpn-${MLVPN_VERSION} && \ 
    libpcap_LIBS="-L${INSTALLDIR}/libpcap/lib -lpcap" libpcap_CFLAGS="-I${INSTALLDIR}/libpcap/include" libsodium_LIBS="-L${INSTALLDIR}/libsodium/lib -lsodium" libsodium_CFLAGS=-I${INSTALLDIR}/libsodium/include libev_LIBS="-L${INSTALLDIR}/libev/lib -lev" libev_CFLAGS=-I${INSTALLDIR}/libev/include ./configure --enable-filters LDFLAGS="-Wl,-Bdynamic" --prefix=${INSTALLDIR}/mlvpn/ --enable-static --disable-shared  && \ 
    make && \ 
    make install &&\
    cd && \
    rm -Rf /root/libev-${EV_VERSION} && \
    rm -Rf /root/libsodium-${LIBSODIUM_VERSION} && \
    rm -Rf /root/libpcap-${PCAP_VERSION} && \
    rm -Rf /root/mlvpn-${MLVPN_VERSION} && \
    cd /root && \
    mkdir mlvpn && \
    mkdir mlvpn/cfg && \
    cd && \
    apt-get --reinstall install -y iptables && \
    apt-get install -y net-tools

COPY ["launch-bonder.sh","/root/mlvpn/"]

COPY ["launch-bonder-1.sh","/root/mlvpn/"]
COPY ["vpn0-bonding-1.conf","vpn0-bonding-1.sh","/root/mlvpn/cfg/"]

COPY ["launch-bonder-2.sh","/root/mlvpn/"]
COPY ["vpn0-bonding-2.conf","vpn0-bonding-2.sh","/root/mlvpn/cfg/"]

COPY ["launch-bonder-3.sh","/root/mlvpn/"]
COPY ["vpn0-bonding-3.conf","vpn0-bonding-3.sh","/root/mlvpn/cfg/"]

COPY ["launch-bonder-4.sh","/root/mlvpn/"]
COPY ["vpn0-bonding-4.conf","vpn0-bonding-4.sh","/root/mlvpn/cfg/"]

COPY ["launch-bonder-5.sh","/root/mlvpn/"]
COPY ["vpn0-bonding-5.conf","vpn0-bonding-5.sh","/root/mlvpn/cfg/"]

#CMD ["sh /root/mlvpn/launch-bonder.sh"]
RUN chmod 777 /root/mlvpn/launch-bonder.sh
ENTRYPOINT ["/root/mlvpn/launch-bonder.sh"]


#RUN chmod 777 '/root/mlvpn/launch-bonder-5.sh' 
#ENTRYPOINT ["/root/mlvpn/launch-bonder-5.sh"]

#RUN chmod 777 '/root/mlvpn/launch-bonder-2.sh'
#ENTRYPOINT ["/root/mlvpn/launch-bonder-2.sh"]

#RUN chmod 777 '/root/mlvpn/launch-bonder-3.sh'
#ENTRYPOINT ["/root/mlvpn/launch-bonder-3.sh"]

#RUN chmod 777 '/root/mlvpn/launch-bonder-4.sh'
#ENTRYPOINT ["/root/mlvpn/launch-bonder-4.sh"]

#RUN chmod 777 '/root/mlvpn/launch-bonder-1.sh'
#ENTRYPOINT ["/root/mlvpn/launch-bonder-1.sh"]

