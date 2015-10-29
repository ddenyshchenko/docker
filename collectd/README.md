
## Collectd docker

## Info

Just run this docker on your host in oreder to send metrcis to graphite

## Configuration

Edit docker-compose.yml and provide vaules:

hostname - set hostname of host where metrics will collected, it will be shown in Grafana UI

extra_hosts - set ip address of graphite host. DNS name graphite is used in /etc/collectd/collectd.conf, so use extra_host option in order to register name graphite in /etc/hosts

## How to run

docker-compose up -d

docker-compose logs