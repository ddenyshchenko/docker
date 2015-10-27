FROM ubuntu:trusty

RUN apt-get clean && \
    apt-get update && \
    apt-get  --no-install-recommends -y install wget \
                                                vim \
                                                openssh-server \
                                                openssh-sftp-server \
                                                openssh-client \
                                                supervisor \
                                                telnet \
                                                unzip \
                                                dnsutils \
                                                git \
                                                ca-certificates \
                                                build-essential \
                                                libldap2-dev libssl-dev libpcre3-dev


# Set time zone
RUN echo "Europe/Kiev" > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

# change root password and configure ssh
RUN echo root:root | chpasswd && \
    sed -i 's/^PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && \
    mkdir /var/run/sshd && \
    chmod 0755 /var/run/sshd

RUN mkdir /nginx /httpcert /httpconfig /httpinfo

WORKDIR /nginx
RUN wget http://nginx.org/download/nginx-1.8.0.tar.gz && \
    tar xzvf nginx-1.8.0.tar.gz
RUN git clone https://github.com/kvspb/nginx-auth-ldap.git
WORKDIR nginx-1.8.0

RUN ./configure --user=nginx --group=nginx --prefix=/etc/nginx \
    --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf \
    --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock \
    --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log \
    --with-http_gzip_static_module --with-http_stub_status_module --with-http_ssl_module \
    --with-pcre --with-file-aio --with-http_realip_module --add-module=/nginx/nginx-auth-ldap \
    --with-debug && \
    make && \
    make install

RUN mkdir /etc/nginx/certs

WORKDIR /

ADD configs/supervisord.conf /etc/supervisord.conf
ADD configs/nginx.conf /etc/nginx/
ADD configs/conf.d/docker-registry.conf /etc/nginx/conf.d/
ADD configure.sh /httpconfig/
ADD index.html /httpinfo/

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -rf /downloads

CMD ln -sf /etc/nginx/certs/intdockerCA.crt /httpcert/ca.crt && \
    supervisord
