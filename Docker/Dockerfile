############################################################
# Dockerfile to build Guestbook container images
# Based on Ubuntu
############################################################
FROM ubuntu:14.04
# Install deps
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python-software-properties
#RUN apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common git python-dev wget apt-transport-https libffi-dev libssl-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python-pip
# Install Ansible
RUN DEBIAN_FRONTEND=noninteractive apt-add-repository -y ppa:ansible/ansible
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ansible
# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Ansible stuff starts here
ADD requirements.yml /etc/ansible/requirements.yml
RUN ansible-galaxy install -r /etc/ansible/requirements.yml
ADD site.yml /etc/ansible/site.yml
# Install Ansible inventory file
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts
RUN ansible-playbook /etc/ansible/site.yml

# Expose the default port
EXPOSE 80

MAINTAINER Ravi Bhure <ravibhure@gmail.com>
