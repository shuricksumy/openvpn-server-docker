# openvpn-server

## 1. Build new Docker
```bash
git clone LINK
cd ./LINK
git submodule init
git submodule sync
git submodule update --remote
./build.sh
```

## 2. Examples of usage
### 2.1 One openvpn server
```bash
cd ./examples/basic/
```
### 2.2 Two openvpn servers with the same certificates but different ports to connect
```bash
cd ./examples/two_servers_one_certs/
```

### 3.3 OpenVPN server configuration for Mikrotik routers
Mikrotik is painful as to OpenVPN and has a lot of issues in client
After creating Docker
1. In server.conf file comment next row `#topology subnet`
2. Use only TCP connection - mikrotik has fewer bugs here
3. Set in mikrotik client config `Auth. = null`
```bash
cd ./examples/mikrotik/
```

## 4. [openvpn-ui](https://github.com/shuricksumy/openvpn-ui) variables 
```bash
 OPENVPN_ADMIN_USERNAME=admin # Leave this default as-is and update on first-run
 OPENVPN_ADMIN_PASSWORD=admin # Leave this default as-is and update on first-run
 SITE_NAME='Server 1' # The name of the server - displayed on UI. Default value "Admin"
 OPENVPN_SERVER_DOCKER_NAME="openvpn-server-1" # The name of the Docker container to restart
 OPENVPN_MANAGEMENT_ADDRESS="IP:PORT" # The preconfigured address to connect OpenVPN manager
```

## 5. [openvpn-install](https://github.com/shuricksumy/openvpn-install) variables
```bash
DOCKER_COMMAND="1-4"

    1) Install packages
    2) Configure openvpn and setup files
    3) Create new Client
    4) Generate .ovpn file
```
```bash
AUTO_INSTALL="y|n"

    "y" - install without questions with predefined variables [default]
```
### 2.1 Server setup variables
```bash
DOCKER_COMMAND="2"
  ||
  ENDPOINT="<Public IP>"
  TUN_NUMBER="12"
  APPROVE_IP="y"
  IPV6_SUPPORT="n"
  AUTO_INSTALL="y"
  DISABLE_DEF_ROUTE_FOR_CLIENTS="y|n"
  CLIENT_TO_CLIENT="y"
  SET_MGMT="<IP:PORT>"
  IP_CHOICE="1-2"
    |   |
    |   [1] IP_RANGE="10.8.0.0" [default]
    |   [2] IP_RANGE="<your internal ovpn ip subnetwork>" [set custom] 
    |
    PORT_CHOICE="1-3"
    |   |
    |   [1] PORT="1194" [default]
    |   [2] PORT="<your port>"
    |   [3] PORT="<random generator>"
    |
    PROTOCOL_CHOICE="1-2"
    |   |
    |   [1] PROTOCOL="udp" [default]
    |   [2] PROTOCOL="tcp"
    |
    DNS="1-13"
    |    |
    |    [1]  Current system resolvers
    |    [2]  Self-hosted DNS Resolver (Unbound) [not tested with Docker]
    |    [3]  Cloudflare (Anycast: worldwide)
    |    [4]  Quad9 (Anycast: worldwide)
    |    [5]  Quad9 uncensored (Anycast: worldwide)
    |    [6]  FDN (France)
    |    [7]  DNS.WATCH (Germany)
    |    [8]  OpenDNS (Anycast: worldwide)
    |    [9]  Google (Anycast: worldwide)
    |    [10] ---- FUCK RUSSIA
    |    [11] AdGuard DNS (Anycast: worldwide) [default]
    |    [12] NextDNS (Anycast: worldwide)
    |    [13] Custom 
    |         |
    |         |- DNS1="<your DNS1 IP>"
    |         |- DNS2="<your DNS1 IP>"
    |     
    COMPRESSION_ENABLED="y|n"
    |    | 
    |   [y] COMPRESSION_CHOICE="1-3"
    |    |    |
    |    |    [1] COMPRESSION_ALG="lz4-v2" [default]
    |    |    [2] COMPRESSION_ALG="lz4"
    |    |    [3] COMPRESSION_ALG="lzo"
    |    |  
    |    [n] [default]
    |
    CUSTOMIZE_ENC="y|n"
         | 
        [y] CIPHER_CHOICE="1-6"
         |    |
         |    [1] AES-128-GCM [default]
         |    [2] AES-192-GCM
         |    [3] AES-256-GCM
         |    |
         |    |- HMAC_ALG_CHOICE="1-3"
         |        |
         |        [1] HMAC_ALG="SHA256" [default]
         |        [2] HMAC_ALG="SHA384"
         |        [3] HMAC_ALG="SHA512"
         |    
         |    [4] AES-128-CBC
         |    [5] AES-192-CBC
         |    [6] AES-256-CBC
         |    
         |- CERT_TYPE="1-2"
         |    |
         |    [1] ECDSA [default]
         |    |   |
         |    |   CERT_CURVE_CHOICE="1-3"
         |    |   |
         |    |   [1] CERT_CURVE="prime256v1" [default]
         |    |   [2] CERT_CURVE="secp384r1"
         |    |   [3] CERT_CURVE="secp521r1"
         |    |   |
         |    |   CC_CIPHER_CHOICE="1-2"
         |    |   |
         |    |   [1] CC_CIPHER="TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SHA256" [default]
         |    |   [2] CC_CIPHER="TLS-ECDHE-ECDSA-WITH-AES-256-GCM-SHA384"
         |    |
         |    [2] RSA
         |         |
         |         RSA_KEY_SIZE_CHOICE="1-3"
         |         |
         |         [1] RSA_KEY_SIZE="2048" [default]
         |         [2] RSA_KEY_SIZE="3072"
         |         [3] RSA_KEY_SIZE="4096"
         |         |
         |         CC_CIPHER_CHOICE="1-2"
         |         |
         |         [1] CC_CIPHER="TLS-ECDHE-RSA-WITH-AES-128-GCM-SHA256" [default]
         |         [2] CC_CIPHER="TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384"
         |      
         |- DH_TYPE="1-2"
         |    |
         |    [1] ECDH [default]
         |    |    |
         |    |    DH_CURVE_CHOICE="1-3"
         |    |    |
         |    |    [1] DH_CURVE="prime256v1" [default]
         |    |    [2] DH_CURVE="secp384r1"
         |    |    [3] DH_CURVE="secp521r1"
         |    |    
         |    [2] DH
         |         |
         |         $DH_KEY_SIZE_CHOICE="1-3"
         |         |
         |         [1] DH_KEY_SIZE="2048" [default]
         |         [2] DH_KEY_SIZE="3072"
         |         [3] DH_KEY_SIZE="4096"
         |
         |- TLS_SIG="1-4"
         |    |
         |    [1] tls-crypt
         |    [2] tls-auth
         |    [3] tls-crypt-v2 [default]
         |    [4] no tls
         |   
         [n] [default]
             | CIPHER="AES-128-GCM"
             | CERT_TYPE="1" # ECDSA
             | CERT_CURVE="prime256v1"
             | CC_CIPHER="TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SHA256"
             | DH_TYPE="1" # ECDH
             | DH_CURVE="prime256v1"
             | HMAC_ALG="SHA256"
             | TLS_SIG="3" # tls-crypt-v2
         
       

```
### 5.2 Client setup variables
```bash
DOCKER_COMMAND="3" 
CLIENT="<client name>"
PASS="1-2"
 |
 [1] no password [default]
 [2] CL_PASS="<client password>"
```
