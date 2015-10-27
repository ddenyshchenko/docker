# nginx

## Components

nginx
http://nginx.org/download/nginx-1.9.3.tar.gz

ldap module
https://github.com/kvspb/nginx-auth-ldap

## How to install

in nginx source folder

```
mkdir nginx && cd nginx && git clone https://github.com/kvspb/nginx-auth-ldap.git

./configure --user=nginx --group=nginx --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --with-http_gzip_static_module --with-http_stub_status_module --with-http_ssl_module --with-pcre --with-file-aio --with-http_realip_module --add-module=/nginx/nginx-auth-ldap --with-debug

make

make install
```