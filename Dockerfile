# Smallest base image
#WORKDIR /opt
#EXPOSE 1194

FROM debian:stable

RUN apt update && apt install -y iproute2 curl
ADD scripts/openvpn-install-v2.sh /opt/openvpn-install-v2.sh
ADD scripts/setup.sh /opt/setup.sh
ADD scripts/install_pkg.sh /opt/install_pkg.sh

RUN /opt/install_pkg.sh

CMD /opt/setup.sh