#!/bin/bash

# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#entrypoint

set -e

if [ "$1" = 'start' ]; then
  rtl_tcp &

  sleep 1
  rtlamr -format=json | \
    jq --compact-output '.Message | select(.ID == (env.MESSAGE_ID | tonumber)) | {meter_id: .ID, consumption: .Consumption}' | \
    mosquitto_pub -h $MQTT_HOST -p $MQTT_PORT -u $MQTT_USER -P $MQTT_PASS -t $MQTT_TOPIC --stdin-line
fi

exec "$@"
