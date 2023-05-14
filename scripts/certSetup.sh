#!/bin/bash

# This script is used to set up the certificates for elasticsearch-certutil
ELASTIC_PASSWORD=$1
KIBANA_PASSWORD=$2

cd /usr/share/elasticsearch

if [ ! -f config/certs/ca.zip ]; then
  echo "Creating CA";
  bin/elasticsearch-certutil ca --silent --pem -out config/certs/ca.zip;
  unzip config/certs/ca.zip -d config/certs;
fi;
if [ ! -f config/certs/certs.zip ]; then
  echo "Creating certs";
  echo -ne \
  "instances:\n"\
  "  - name: esnode1\n"\
  "    dns:\n"\
  "      - esnode1\n"\
  "      - localhost\n"\
  "    ip:\n"\
  "      - 127.0.0.1\n"\
  > config/certs/instances.yml;
  bin/elasticsearch-certutil cert --silent --pem -out config/certs/certs.zip --in config/certs/instances.yml --ca-cert config/certs/ca/ca.crt --ca-key config/certs/ca/ca.key;
  unzip config/certs/certs.zip -d config/certs;
  echo "Setting file permissions"
  chown -R root:root config/certs;
  find . -type d -exec chmod 750 \{\} \;;
  find . -type f -exec chmod 640 \{\} \;;
  echo "Waiting for Elasticsearch availability";
  until curl -s --cacert config/certs/ca/ca.crt https://esnode1:9200 | grep -q "missing authentication credentials"; do sleep 30; done;
  echo "Setting kibana_system password";
  until curl -s -X POST --cacert config/certs/ca/ca.crt -u "elastic:${ELASTIC_PASSWORD}" -H "Content-Type: application/json" https://esnode1:9200/_security/user/kibana_system/_password -d "{\"password\":\"${KIBANA_PASSWORD}\"}" | grep -q "^{}"; do sleep 10; done;
fi;
echo "Good to go! Logs:"
exit 0;
