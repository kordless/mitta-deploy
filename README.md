# mitta-deploy
This repository contains system dependencies to deploy a standalone AI-powered crawling and indexing system onto Google Cloud. This system provides utilities to index websites or other documents. The system may be configured to use machine learning models which can assist with tagging and classification tasks for documents stored in the system.

An optional front-end with user authentication is available from [Mitta.us](https://mitta.us/) which runs on AppEngine. Please [contact us](https://mitta.us/onpremise) for pricing information.

The following systems are managed with this repo:

- **fastener**: manages solr instances
- **solr**: deploys solr instances
- **grub**: crawl and image a website
- **mitta-api**: APIs to tie together above systems

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

## Mitta-API
The Mitta-API deployment provides thin API for managing Solr via the fastener deployment, as well as indexing documents crawled by the Grub systems. The Mitta deployment provides simple API calls to query Solr for documents, as well as passing documents into various machine learning models. The APIs allow for updating documents in Solr with any meta data received from models.

