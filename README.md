# mitta-deploy
This repository contains system dependencies to deploy a standalone crawling and indexing system for websites and document. An optional paid front-end is available via Mitta and runs on AppEngine.

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
The Grub deployment uses a Selenium box for imaging and extracting data from websites. Gunicorn is used to provide some scalability.

## Mitta
The Mitta deployment provides thin API for managing Solr via the fastener deployment, as well as indexing documents crawled by the Grub systems. The Mitta deployment provides simple API calls to query Solr for documents, as well as passing documents into various machine learning models. The APIs allow for updating documents in Solr with any meta data received from models.

