# Marcel - Odoo Source Code Deployment
This project started by taking Odoo v14 and containerising the source code. The project aims automate the process of initialising a fully functioning production ready system that functions in docker containers.

## Table of Contents

## User Story

## Features

## Technologies Used

## Bugs

## Deployment


## Development Cycle
-> git clone https://github.com/odoo/odoo.git
-> create a virtual environment in base dir
    python3 -m venv .odoo_env

-> Dockerfile with FROM python:3.8-buster
-> run command in CMD => docker build -t test-container .
-> run command in CMD => docker run -dp 3001:3001 test-container

-----------------------------
-> Postgres database is created in docker-compose.yml
-> Once up use: 'docker ps'
-> docker inspect {container id}
-> Look at the network ports section = "Ports": {
                                            "5432/tcp": [
                                                {
                                                    "HostIp": "0.0.0.0",
                                                    "HostPort": "5450"
                                                }
                                            ]
                                        },
-> Also note the "Gateway": "172.18.0.1", "IPAddress": "172.18.0.2", <<== this is subject to change
-> Use dbeaver and connect on the HostIP + Port

-> psql -h <REMOTE HOST> -p <REMOTE PORT> -U <DB_USER> <DB_NAME>

---------------------

1) Click on manage database
2) Click on SET MASTER PASSWORD == masterpassword
3) Go back to login
4) login using username==admin & password==admin
5) Click in top left corner
6) Click on setting
7) Change default admin password
