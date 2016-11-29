Three node guestbook app using aws, terraform and ansible.

##Topics

- [Overview](#overview)
    * Example AWS Setup
    * Additional Considerations
- [App Stack Details](#app-stack-details)
    * PostgreSQL Instance
    * Redis Instance
    * Application Instance
- [Architecture Diagram](#architecture-diagram)

##Overview

This document describes our approches for deploying highly available ruby app on AWS. This architecture will provide us highly available application running on AWS under VPC.

###Example AWS Setup

This guide will use the following configuration for illustrative purposes:

Instance Networking:
All instances: Public network

###Additional Considerations

1. This document provides examples using Ubuntu14 (LTS).

2. This document assumes you already install [terraform](https://releases.hashicorp.com/terraform/0.6.16/terraform_0.6.16_linux_amd64.zip), [Ansible](http://docs.ansible.com/intro_installation.html) on your local machine. 

###App Stack Details

#### 1 - PostgreSQL Instance

Postgresql server which will runs database for guestbook app.

#### 2 - Redis Instance

Redis server which will runs database for guestbook app.

#### 3 - Application Instance(s)

The Application servers will run our guestbook app on it. This instance running ruby 2.3.0 and nginx for reverse proxy (on port 80) for rails app.
   

## Architecture Diagram

![3node](3node-diag.png)
