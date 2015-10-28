# Secure docker Registry

## Info

Secure Docker Registry v1

Consists from dockers:
 On backend:
	- docker with registry v1
	- docker with docker UI (docker-registry-frontend)
 On frontend:
	- docker with nginx configured with ssl and LDAP authentification

## How to run

```
docker-compose up -d
```


## Inside nginx configuration

For ssl you can use self signed certificate

```
openssl genrsa -out intdockerCA.key 2048
openssl req -x509 -new -nodes -key intdockerCA.key -days 10000 -out intdockerCA.crt -subj "/C=UA/ST=Kyiv/L=Kyiv/O=IntroPro/CN=docker-registry.domain.com"
openssl genrsa -out docker-registry.domain.com.key 2048
openssl req -new -key docker-registry.domain.com.key -out docker-registry.domain.com.csr -subj "/C=UA/ST=Kyiv/L=Kyiv/O=IntroPro/CN=docker-registry.domain.com"
openssl x509 -req -in docker-registry.domain.com.csr -CA intdockerCA.crt -CAkey intdockerCA.key -CAcreateserial -out docker-registry.domain.com.crt -days 10000
```

For LDAP used nginx-auth-ldap module [GitHub Link](https://github.com/kvspb/nginx-auth-ldap).


## Client configuration

Manual:

There are several ways to configure docker client to use registry with SSL:
1. Add to your docker config file  "--insecure-registry docker-registry.domain.com"
or
2. Put CA certificate to /etc/docker/certs.d/docker-registry.domain.com:5000 directory and reboot your docker service.

Automatic:

```
wget -qO- http://docker-registry.domain.com:7081 | sh
```

## How to use:

### Links

1. UI for registry
use https://docker-registry.domain.com:8080

2. Docker registry
use https://docker-registry.domain.com:5000


### How to add image to registry

1. Login

	```
	docker login docker-registry.domain.com:5000

	enter your LDAP credentials
	```

2. Tag your image

	```
	docker tag myimage:latest docker-registry.domain.com:5000/username/myimage:latest
	```

3. Push to registry

	```
	docker push docker-registry.domain.com:5000/username/myimage:latest
	```
