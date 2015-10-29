
## Graphite-grafana docker

## How to run

docker-compose up -d

docker-compose logs

## Connect graphite to grafana

1. Go to the Grafana UI (for example http://localhost:port)

Check exposing port in dokcer-compose.yml

2. Data Sources -> Add New

3. Add graphite as source.

Name: Graphite

Type: Graphite

Url: http://graphite:8080

DNS graphite. linked to graphite docker in docker-compose.yml. Check docker /etc/hosts tp troubleshoot/

