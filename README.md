# eesti-energia-test
Repository for the job interview task of Eesti Energia SRE position

## Preword
Thanks for the interesting and well built task. It was defenitely interesting and fun to setup. Learned a lot of new things.
As last week and the weekend was a bit hectic for me, there are quite a few aspects that i would have liked to solve more elegantly if i had more time.
I will add list of improvements i would make if i had more time to the bottom of this README.

## Pre-Requirements
1. Host machine for docker **must support bash** in order to run the .initDockerCompose.sh script (**Linux, WSL2, MacOS, RaspberryPi, Linux VM etc..**)
     * If you are on windows, Windows Subsystem For Linux  (WSL) is a good option: https://learn.microsoft.com/en-us/windows/wsl/install
3. Install the latest version of Docker (and docker compose): https://docs.docker.com/get-docker/

## Setup
1. Clone the repository:
`git clone https://github.com/randoromm/eesti-energia-test.git`
2. Navigate to the root directory of the repository
`cd eesti-energia-test/`
3. Run the initialisation script:
`bash initDockerCompose.sh`
3.1 Alternatively, without the "auto fail setup" feature you can run the compose file manually:
`docker-compose up --wait`

## Management
* Read the log files
`docker-compose logs {OPTIONAL:$SERVICE_NAME}`
examples:
`docker-compose logs ansible`
* Attach to the containers for STDOUT live log output
`docker-compose up`

## Improvements i would make:
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

