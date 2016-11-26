# AskCharlie

This repo contains multiple way to start your ruby guestbook application in mulitple environment..

### Vagrant

To use vagrant deployment follow the steps in `Vagrant/README.md`

do not forget to run `ansible-galaxy install -r requirements.yml` before you `vagrant up`

#### digitalocean

To use digitalocean deployment follow the steps in `digitalocean/README.md`

do not forget to run `ansible-galaxy install -r requirements.yml` before you `terraform apply`

#### Docker

To use docker deployment follow the steps in `Docker/README.md`

do not forget to run `ansible-galaxy install -r requirements.yml` before you `docker run`

#### aws_multi_node

To use aws multi node deployment follow the steps in `aws_multi_node/README.md`

do not forget to run `ansible-galaxy install -r requirements.yml` before you `terraform apply`

#### multi_tier_app_vpc 

[WIP] missing ansible deployment

To use multi tier application deployment in aws vpc follow the steps in `multi_tier_app_vpc/README.md`

do not forget to run `ansible-galaxy install -r requirements.yml` before you `terraform apply`
