# mitta-deploy
This repository contains system dependencies to deploy Mitta on-prem. The excluded component of this deployment is the Mitta code which runs on AppEngine.

The following systems are managed with this repo:

- *fastener*: manages solr instances
- *solr*: deploys solr instances
- *grub*: crawl and image a website

## Checkout
Checkout the mitta-deploy repository to a cloud shell terminal on Google Cloud:

## Credentials and Secrets


## Fastener
The fastener box is responsible for managing preemptive Solr instances. Start by deploying a single fastener box:

```
cd fastener
./deploy-fastener.sh
```

Once the instance is running, SSH into it and then look for the RUN_START_WEB file. Once the file is in place, run:

```
./start-web.sh
```

The SSH session may now be closed. To reconnect to the process, use screen:

```
screen -X fastener
```

## Solr
The Solr deployment deploys the Solr search engine. Instances run single node Solr, which can create and manage multiple indexes/collections.

## Grub
