#!/bin/bash

CACHED_SSL_CONF=/apps/dist/ssl

if [ -e "$CACHED_SSL_CONF" ]; then
    echo "Using HTTPS SSL configuration cached in dist/ssl"
    cp -rp /apps/dist/ssl /apps
else
    # SSL Certificate (self-signed)
    mkdir -p /apps/ssl/{key,csr,cert,cnf}

    KEY=/apps/ssl/key/borrowlocal.key
    CSR=/apps/ssl/csr/borrowlocal.csr
    CRT=/apps/ssl/cert/borrowlocal.crt
    CNF=/apps/ssl/cnf/borrowlocal.cnf

    cat > "$CNF" <<END
[ req ]
prompt                  = no
distinguished_name      = borrowlocal_dn
req_extensions = v3_req

[ borrowlocal_dn ]
commonName              = borrowlocal
stateOrProvinceName     = MD
countryName             = US
organizationName        = UMD
organizationalUnitName  = Libraries

[ v3_req ]
subjectAltName = @alt_names

[alt_names]
DNS.1 = borrowlocal
DNS.2 = localhost
IP.1 = 192.168.33.20
IP.2 = 127.0.0.1
END

    # Generate private key 
    openssl genrsa -out "$KEY" 2048

    # Generate CSR 
    openssl req -new -key "$KEY" -out "$CSR" -config "$CNF"

    # Generate self-signed cert
    openssl x509 -req -days 365 -in "$CSR" -signkey "$KEY" -out "$CRT" \
        -extensions v3_req -extfile "$CNF"

    # cache the SSL cert info for the next run of Vagrant
    cp -rp /apps/ssl /apps/dist
fi
