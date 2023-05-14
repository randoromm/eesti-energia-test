# eesti-energia-test
Repository for the job interview task of Eesti Energia SRE position

## Preword
Thanks for the interesting and well built task. It was defenitely interesting and fun to setup. Learned a lot of new things.
As last week and the weekend was a bit hectic for me, there are quite a few aspects that i would have liked to solve more elegantly if i had more time.

### Improvements i would make:
1. Setup API keys for Kibana for more security.
2. Improve elasticsearch SSL certificate management for more security.
      * Could also implement token/api key system here for more security.
4. Encrypt .env file for more security.
5. Create Dockerfiles for Elasticsearch and Kibana container building.
      * This would allow better healthchecks control and failing the compose setup would be easier and more elegant.
      * OR Write the "initDockerCompose.sh" file in another scripting language to support all host machine environments (ex. Python).
      * The "initDockerCompose.sh could also be improved for smoother working and stdout.
6. Configure Ansible properly with (ex. /etc/hosts, config, setup j2 templates).
7. Create Ansible Playbook requests to check if index and data view with that name already exist. (Currently just ignoring the failed PUT/POST requests).
8. Create Ansible it's own access for the endpoint testing. More security!
