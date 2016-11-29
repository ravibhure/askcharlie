Amazon Virtual Private Cloud (Amazon VPC) provides tremendous network routing flexibility and thus secure infrastructure. This document describes highly available infrastructure using aws, terraform and ansible.

##Topics

- [Overview](#overview)
    * Example AWS VPC Setup
    * Additional Considerations
- [App Stack Details](#app-stack-details)
    * NAT Instance - Bastion Host
    * HAProxy Instance
    * PostgreSQL Instance(s)
    * Redis Instance(s)
    * Application Instance(s)
    * Watchdog Monitoring Instance(s)
- [Architecture Diagram](#architecture-diagram)

##Overview

This document describes our approches for deploying highly available ruby app on AWS. This architecture will provide us highly available application running on AWS under VPC.

###Example AWS VPC Setup

This guide will use the following VPC configuration for illustrative purposes:

AWS Networking:
VPC CIDR: 10.0.0.0/16
VPC Public subnet: 10.0.0.0/24
VPC Private subnet: 10.0.1.0/24

Instance Networking:
NAT Instance: Public network
All other instances: Private network

###Additional Considerations

1. This document provides examples using Amazon Linux and Ubuntu14 (LTS).

2. This document assumes you already install [terraform](https://releases.hashicorp.com/terraform/0.6.16/terraform_0.6.16_linux_amd64.zip), [Ansible](http://docs.ansible.com/intro_installation.html) on your local machine. 

###App Stack Details

#### 1 - NAT Instance - Bastion Host

This Bastion host will acts as a 'jump' server are instance that sit within our public subnet and are typically accessed using SSH and allow our application traffic on port 80 from outer world.
Like acts as a 'jump' server, it will allowing you to use SSH to login to other instances (within private subnets) deeper within our network, thus our infrastructure will be more secure and harden.

#### 2 - HAProxy Instance

This HAProxy server will serve and route the traffic for our app stack, this web proxy basically configure to handle the load of the guestbook application and also it will balancing the web traffic. This server makes also works proxy server (TCP) for our database and redis server.

#### 3 - PostgreSQL Instance(s)

Currently its single postgresql server but depends on load we will create multiple and configure replication which will run behind the haproxy for high available.

#### 4 - Redis Instance(s)

Currently its single Redis server but depends on load we will create multiple and configure replication which will run behind the haproxy for high available.

#### 5 - Application Instance(s)

The Application servers will run our guestbook app on it. This instance running ruby 2.3.0 and nginx for reverse proxy (on port 80) for rails app.
   
#### 6 - Watchdog Monitoring Instance

The Watchdog Monitor is a custom instance that you will need to create and develop monitoring scripts to run on. This instance is intended to run and monitor the state of our aws instances and services running on it.


## Architecture Diagram

![awsvpc-diag](awsvpc-diag.png)
