#!/bin/bash

SERVICE_USER_GROUP=vagrant:vagrant

SHIB_HOME=/apps/borrow/shibboleth

cd /apps/dist
if [ -e shibboleth-bin.tar.gz ]; then
    tar xvzf shibboleth-bin.tar.gz --directory /apps/borrow
    chown -R "$SERVICE_USER_GROUP" "$SHIB_HOME"
    exit
fi

test -e log4shib-1.0.9.tar.gz || wget https://shibboleth.net/downloads/log4shib/1.0.9/log4shib-1.0.9.tar.gz
test -e xerces-c-3.1.4.tar.gz || wget https://www.apache.org/dist/xerces/c/3/sources/xerces-c-3.1.4.tar.gz
test -e xml-security-c-1.7.3.tar.gz || wget https://archive.apache.org/dist/santuario/c-library/xml-security-c-1.7.3.tar.gz
test -e xmltooling-1.6.0.tar.gz || wget https://shibboleth.net/downloads/c++-opensaml/2.6.0/xmltooling-1.6.0.tar.gz
test -e opensaml-2.6.0.tar.gz || wget https://shibboleth.net/downloads/c++-opensaml/2.6.0/opensaml-2.6.0.tar.gz
test -e shibboleth-sp-2.6.0.tar.gz || wget https://shibboleth.net/downloads/service-provider/2.6.0/shibboleth-sp-2.6.0.tar.gz

mkdir -p /apps/src
mkdir -p "$SHIB_HOME"

cd /apps/src
tar xvzf ../dist/log4shib-1.0.9.tar.gz
cd log4shib-1.0.9
./configure --disable-static --disable-doxygen --prefix="$SHIB_HOME" || exit 1
make && make install

cd /apps/src
tar xvzf ../dist/xerces-c-3.1.4.tar.gz
cd xerces-c-3.1.4
./configure --prefix="$SHIB_HOME" --disable-netaccessor-libcurl || exit 1
make && make install

cd /apps/src
tar xvzf ../dist/xml-security-c-1.7.3.tar.gz
cd xml-security-c-1.7.3
./configure --without-xalan --with-xerces="$SHIB_HOME" --disable-static --prefix="$SHIB_HOME" || exit 1
make && make install

cd /apps/src
tar xvzf ../dist/xmltooling-1.6.0.tar.gz
cd xmltooling-1.6.0
./configure --with-log4shib="$SHIB_HOME" --prefix="$SHIB_HOME" -C || exit 1
make && make install

cd /apps/src
tar xvzf ../dist/opensaml-2.6.0.tar.gz
cd opensaml-2.6.0
./configure --with-log4shib="$SHIB_HOME" --prefix="$SHIB_HOME" -C || exit 1
make && make install

cd /apps/src
tar xvzf ../dist/shibboleth-sp-2.6.0.tar.gz
cd shibboleth-sp-2.6.0
./configure --with-log4shib="$SHIB_HOME" --prefix="$SHIB_HOME" --enable-apache-24 --with-apxs24=/usr/bin/apxs || exit 1
make && make install

chown -R "$SERVICE_USER_GROUP" "$SHIB_HOME"
tar cvzf /apps/dist/shibboleth-bin.tar.gz --directory /apps/borrow shibboleth
