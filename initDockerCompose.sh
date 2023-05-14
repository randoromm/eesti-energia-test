#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' #no color
docker-compose down
docker-compose up --wait
for line in $(docker-compose ps -aq)
do
    if [[ "$(docker inspect "${line}" --format='{{.State.ExitCode}}')" != "0" ]]; 
    then
        container_name="$(docker inspect "${line}" --format '{{ .Name }}')"
        echo "$container_name exit code: $(docker inspect "${line}" --format='{{.State.ExitCode}}')" 
        echo -e "${RED}Service UNHEALTHY! Canceling Startup!!!${NC}"
        docker-compose down
    else
        container_name="$(docker inspect "${line}" --format '{{ .Name }}')"
        echo "$container_name exit code: $(docker inspect "${line}" --format='{{.State.ExitCode}}')" 
        echo -e "${GREEN}Service Healthy!${NC}"
    fi
done
