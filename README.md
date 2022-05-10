# mitta-deploy
This repository contains system dependencies to deploy Mitta on-prem. The excluded component of this deployment repository is the Mitta code that runs on AppEngine.

The following systems are managed with this repo:

- fastener: manages solr instances
- solr: deploys solr instances
- grub: crawl and image a website

## Checkout
Checkout the mitta-deploy repository to a cloud shell terminal on Google Cloud:

## Credentials

## Fastener
The fastener box is responsible for managing pre-emptible Solr instances. Start by deploying a single fastener box:

```
cd fastener
./deploy-fastener.sh
```

Once the instance is running, SSH into it and then look for the RUN_START_WEB file. Once the file is in place, run:

```
./start-web.sh
```

