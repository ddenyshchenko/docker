# Secure docker Registry

## Info

Secure Docker Registry v1

Consists from dockers:
 On backend:
	- docker with registry v1
	- docker with docker UI (docker-registry-frontend)
 On frontend:
	- docker with nginx configured with ssl and LDAP authentification

## Client configuration

Manual:

```
sudo mkdir -p /etc/docker/certs.d/docker-registry.domain.com\:5000
sudo wget http://docker-registry.domain.com:8081/ca.crt -O /etc/docker/certs.d/docker-registry.domain.com\:5000/ca.crt

```
Restart your docker service to apply changes

```
sudo service docker restart
```

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
	docker tag myimage:latest docker-registry.domain.com:5000/reponame/myimage:latest
	```

3. Push to registry
	```
	docker push docker-registry.domain.com:5000/reponame/myimage:latest
	```
