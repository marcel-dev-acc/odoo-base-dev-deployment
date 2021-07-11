# Marcel - Odoo Source Code Deployment
This project started by taking Odoo v14 and containerising the source code. The project aims to automate the process of initialising a fully functioning production ready system that is served from docker containers.

## Table of Contents
- [1. UX](##UX)
  * 1.1. Strategy
  * 1.2. Structure
- [2. Features](#features)
- [3. Technologies Used](#technologies-used)
- [4. Testing](#testing)
- [5. Deployment](#deployment)
- [6. Development Cycle](#development-cycle)
- [7. End Product](#end-product)
- [8. Known Bugs](#known-bugs)
- [9. Credits](#credits)

<a name="UX"></a>
## 1. User Experience
#### [Go to top](##table-of-contents)
The user experience encompasses aspects of how the customer interacts with the product.

### 1.1. Strategy
The purpose of this project is to shorten the learning curve of deploying / developing with Odoo's source code.
The project achieves this goal by providing scripts to be run on linux machines. Additionally, using docker allows packages and source code to be automatically built cutting down the time required to initialise your project and isolating dependencies.

### 1.2. Structure
The structure illustrated below is to showcase the primary files of concerns in this project.
```
|-- docker-compose.yml
|-- Dockerfile
|-- getting-started-scripts.sh
```

<a name="features"></a>
## 2. Features
#### [Go to top](##table-of-contents)

<a name="technologies-used"></a>
## 3. Technologies Used
#### [Go to the top](##table-of-contents)
- shell
- docker
- docker-compose
- python3.8

<a name="testing"></a>
## 4. Testing
#### [Go to top](##table-of-contents)
### Automated Testing
### Manual Testing
### Bugs Resolved

<a name="deployment"></a>
## 5. Deployment
#### [Go to top](##table-of-contents)
A lot of the statements made below will mostly be superficial.
1) Build a [Virtual Box](https://www.virtualbox.org/) machine with an [Ubuntu](https://ubuntu.com/download/flavours) image. Make sure that you have at least 1GB of memory and at least 30GB of storage space.
2) Clone this repository
3) Run or follow the `virtual-box-setup-script.sh`
4) Once you are back on the machine, run `getting-started-script.sh`

## 6. Development Cycle
#### [Go to top](##table-of-contents)
The first issue I had while working with Odoo was how do I develop the source code. The easy installations involved downloading the binaries on Ubuntu and compiling Odoo from binaries, alternatively, on Windows getting the installation files and running Odoo that way.

A bit of research yielded access to the source code which is mirrored on [GitHub](https://github.com/odoo/odoo). The source code is fairly easy to access, simply clone the repository and there is it. Odoo's documentation on [installing](https://www.odoo.com/documentation/14.0/administration/install.html) from source is fairly explicit. It covers all the necessary requirements and walks the user through the base setup. Sadly, when things do inevitably go wrong, as the documentation is lacking in certain areas, the user has to rely on their own knowledge and that of any forum's that have tried resolving similar issues. One concern raised from the previously mentioned is that the whole concept of installing from source is not packaged, and almost quite raw. Granted the installation is supposed to serve only as a tool for basic development. A work-around is starting an Odoo project using pre-compiled docker images, sadly, this takes you back to the initial problem of altering the source code for your own requirements.

The next stage was therefore to come up with an automated way of getting a development environment, that was built from source code, to be as production ready as possible. There requirement for our production environment fall down on three core frameworks to implement:
1. Odoo source code acting as a web-framework
2. A connected Postgres database, as required by Odoo
3. NGINX to handle incoming web traffic on port 80

Knowing that this would be the general structure of the project it was time to work towards getting an Odoo container created from the source code using a Dockerfile. The Dockerfile was created following the install Odoo from source walk-through, it therefore assumed that the container was the base machine. The next assumption was that the Postgres database would be externally hosted (i.e. on another machine) and would be connected to using either a .conf file or by passing the parameters. The way that seemed least painless was by passing the parameters. Originally, attempts were made to link the two containers the recommended docker-compose way through countless tutorials online, sadly, these involved using the pre-built images from docker and linking the network. It practice this works well, but, it does not address the initial issue of being able to touch the source code on your production environment.

## 7. End Product
#### [Go to top](##table-of-contents)

## 8. Known Bugs
#### [Go to top](##table-of-contents)

## 9. Credits
#### [Go to top](##table-of-contents)
This section will be used to link to helpful resources that were used along the way. This external resources are not maintained by us, and therefore broken links are a possibility.
- [Odoo GitHub](https://github.com/odoo/odoo)
- [Inspiration for the Dockerfile from Odoo installation documentation](https://www.odoo.com/documentation/14.0/administration/install.html)
- [Enabling an SSH server on Virtual Box](https://linuxize.com/post/how-to-enable-ssh-on-ubuntu-18-04/)
- [Virtual box network setup](https://bobcares.com/blog/virtualbox-ssh-nat/)
- [Connecting to GitHub using SSH](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh)
- [Installing docker](https://docs.docker.com/engine/install/ubuntu/)


### Fundamentals
#### [Go to top](##table-of-contents)
To get up and running a few hacks were required to get to a stage where things could be running in an automated fashion. Below is a log of command / ideas that happened sequentially to get this project to a running stage.
NOTE: The below will be tidied up eventually, once the automation of the container is complete, then others can use this a basis for their own projects.
```
-> git clone https://github.com/odoo/odoo.git
-> create a virtual environment in base dir  <<=== no longer required
    python3 -m venv .odoo_env

-> Dockerfile with FROM python:3.8-buster
-> run command in CMD => docker build -t test-container . <<== this required some form of a running process such as python3 -m http.server 3000
-> run command in CMD => docker run -dp 3001:3001 test-container

-----------------------------
-> Postgres database is created in docker-compose.yml <<== just using the basic image outlined on dockers website
-> Once up use: 'docker ps' (this allowed you to see what container id postgres was on)
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
The above command was used once in the odoo container to identify whether postgres was actually on the same network, it turned out that it was connected and on the same netowrk, just Odoo was recognising the details through docker-compose.
This was frustrating because when you use the pre-built images from docker, it all worked!
---------------------
Once Odoo was responding on localhost:XXXX I needed to configure and secure the database, the below steps were taken
1) Click on manage database
2) Click on SET MASTER PASSWORD == masterpassword
3) Go back to login
4) login using username==admin & password==admin
5) Click in top left corner
6) Click on setting
7) Change default admin password
```