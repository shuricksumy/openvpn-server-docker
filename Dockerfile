FROM debian:stable

WORKDIR /etc/openvpn/easy-rsa
EXPOSE 1194

RUN apt update && apt install -y iproute2 curl
ADD scripts/openvpn-install-v2.sh /opt/openvpn-install-v2.sh
ADD scripts/setup.sh /opt/setup.sh
ADD scripts/install_pkg.sh /opt/install_pkg.sh
ADD scripts/EasyRSA-3.1.6.tgz ~/EasyRSA-3.1.6.tgz

RUN /opt/install_pkg.sh

CMD /opt/setup.sh