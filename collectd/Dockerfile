FROM ubuntu:trusty

RUN apt-get update && \
    apt-get install -y --no-install-recommends collectd wget

ADD collectd.conf /etc/collectd/

RUN apt-get clean && \
    rm -rf /tmp/* /var/tmp/*

CMD /usr/sbin/collectd -f