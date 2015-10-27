#!/bin/bash
openssl genrsa -out intdockerCA.key 2048
openssl req -x509 -new -nodes -key intdockerCA.key -days 10000 -out intdockerCA.crt -subj "/C=UA/ST=Kyiv/L=Kyiv/O=IntroPro/CN=docker-registry.domain.com"
openssl genrsa -out docker-registry.domain.com.key 2048
openssl req -new -key docker-registry.domain.com.key -out docker-registry.domain.com.csr -subj "/C=UA/ST=Kyiv/L=Kyiv/O=IntroPro/CN=docker-registry.domain.com"
openssl x509 -req -in docker-registry.domain.com.csr -CA intdockerCA.crt -CAkey intdockerCA.key -CAcreateserial -out docker-registry.domain.com.crt -days 10000
