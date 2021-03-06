# Grub 2.0
Grub-2.0 is a machine learning crawler. Skip to [the install instead](https://github.com/kordless/grub-2.0#install)?

Grub provides machines and humans the ability to find, explore and extract image based content, including content found on-line on the [World Wide Web](https://en.wikipedia.org/wiki/World_Wide_Web).

One or more machine learning models may be used to inspect and extract text or images from page screenshots imaged using a [Selinium](https://selenium-python.readthedocs.io/installation.html) box. Screen images from a page "crawl" are processed by various models and the results are placed into an index where they may be searched or related to other content using [Solr's facet API](https://lucene.apache.org/solr/guide/8_7/json-facet-api.html).

Here is an example where we use Grub's crawler to image [a page about photographing snowflakes](https://mymodernmet.com/nathan-myhrvold-snowflake-images/) and then send that image to an [OpenCV model](https://pypi.org/project/opencv-python/) to crop and extract larger imagery found on the page (in this case a photo of a snowflake). Passing the original article and the image of the snowflake to Google Vision's model returns text which may be added to a document already in the index.

<img src="https://raw.githubusercontent.com/kordless/grub-2.0/main/docs/snowflake_google_vision.png" width="360">

Once we have tags from the model, we can see if how they relate to the tags and text that exists in other documents.

## History
[Grub "One Oh"](https://en.wikipedia.org/wiki/Grub_(search_engine)) was an Open Source search engine inspired by [SETI@Home](https://setiathome.berkeley.edu/) and built to distribute the job of gathering content from the web. At one point several hundred volunteers were crawling the web for the project, sending in content changes only when pages were noted to have been updated. One of the main requests received by the team was the ability for volunteers to add their own curated content.

Grub was sold in 2003 to Looksmart and [then again in 2007 to Wikimedia](https://readwrite.com/2007/07/27/wikia_acquires_grub_from_looksmart/), where it fell into inactivity. The original Grub team would later find itself working at Splunk, marketing and porting it to Windows.

Grub-2.0 is the rebirth and expansion upon the idea of decentralized search processes through AI-powered vision systems. It is only now that we have the technology to see the original vision of search for the people to become a reality.

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Grub.svg/440px-Grub.svg.png" width="200">

## AGI Business Models for Profit
[AGI](https://en.wikipedia.org/wiki/Artificial_general_intelligence) stands for artificial general intelligence. 

> "AI-complete problems are hypothesized to include general computer vision, natural language understanding, and dealing with unexpected circumstances while solving any real-world problem." - Wikipedia

Many people can "see" a taxi *in mind* when someone says the word *taxi* to them. Where does this imagined taxi come from when the spoken request is being processed by the mind? The ancients thought this imagery came in from internal sense organs which "saw" things *in mind* that were not real.

<img src="https://upload.wikimedia.org/wikipedia/commons/0/0c/RobertFuddBewusstsein17Jh.png" width="300">

How computer systems create internal imagery in the future may be key to developing strong AI. While that discussion is well outside the scope of this document and a bit hypothetical at this point, you may find further discussions about building machine awareness interesting:

[![synth](https://img.youtube.com/vi/frB8I5gxSXk/0.jpg)](https://www.youtube.com/watch?v=frB8I5gxSXk)

## Competition
Google provides image search functions for the massive amount of content they have crawled. If you can build an optimized query, their semantic knowledge graph built from billions of pages will do a good job of returning related imagery. Here's a demo of using search terms gathered from [Stack Exchange](https://cooking.stackexchange.com/) to help extract relevant imagery from a Google search:

[![synth](https://img.youtube.com/vi/tqggQstJHX8/0.jpg)](https://www.youtube.com/watch?v=tqggQstJHX8&feature=youtu.be)

Like when you use Google, a machine or human using Grub may receive related imagery using search queries such as "robot hand" even if Grub is only shown a few pages on robot hands. This keeps things simple and secure and doesn't require scraping Google results to get imagery into your machine.

Here's an example page fragment created with Grub:

<img src="https://github.com/kordless/grub-2.0/blob/main/docs/h2ssme1AjSKfObij3DMZyQ2.jpg?raw=true" width="500">

Unlike Google, when Grub is given a site it may return one or more images and/or search indexes. Indexes can be queried later by using Solr's time or relatedness functions.

This process may be useful for testing or training machine learning models or providing new types of search features to users, such as what is done over at [mitta.us](https://mitta.us) with timeseries-based document archives.

## How
Grub is a "crawling aperture" which has been implemented in Geckodriver, Firefox, Solr and various machine learning vision models. By passing a website's image to a model, we may find and crop related images or text on the page. When images are cropped out, they may be passed onto other models for additional object extraction.

We may also image and extract the source code of a page (this example uses Google Vision's model):

<img src="https://raw.githubusercontent.com/kordless/grub-2.0/main/docs/index.png" width="500">

Here we see a Google Vision model looking at a Bloomberg article and seeing people, given Cuomo is people. A subsequent search, "cuomo people", would return this article and a picture of Cuomo.

<img src="https://raw.githubusercontent.com/kordless/grub-2.0/main/docs/googlevision.PNG" width="500">

Other models may be run on Tensorflow directly. We'll implement this in the very near future.

Grub runs on [Flask](https://flask.palletsprojects.com/en/1.1.x/) in Python and uses [Solr 8.7](https://lucene.apache.org/solr/), [Webdriver](https://github.com/SeleniumHQ/selenium) and [Tensorflow](https://github.com/tensorflow/tensorflow).

## Install
This repository will help you install scripts and reference code for deploying your own machine learning crawler.

Begin by checking out this repository onto your Google Cloud Shell terminal:

```
$ git clone https://github.com/kordless/grub-2.0.git
```

<img src="https://github.com/kordless/grub-2.0/blob/main/docs/googlecloud.PNG?raw=true" width="500">

## Edit the secrets.sh file:

```
$ cd grub-2.0
$ vi secrets.sh
TOKEN=f00bark
:x
```

Then copy it into script directories:

```
$ cp secrets.sh grub-scripts
$ cp secrets.sh solr-scripts
$ cp secrets.sh tensor-scripts
```

## Deploy Solr
Deploy a secure Solr instance on Google cloud:

```
$ ./deploy-solr.sh
Password token is: f00bark
```

Instances will be running in a few minutes, listening on port 8389 for Solr.

Yes, the default port numbers for Solr have been transposed.

### Manage Solr
Login URL looks like: http://solr:f00bark@x.x.x.x:8389

## Deploy Grub
Deploy a secure Grub instance on Google cloud:

```
$ ./deploy-grub.sh
Password token is: f00bark
```

Instances will be running in a few minutes, listening on port 8983 for Grub.


### Run Grub
A request for imaging a URL: 

```
$ curl -X POST -d "url=https://news.ycombinator.com/news" http://grub:f00bark@x.x.x.x:8983/g
{"result": "success", "filename": "1ORJX7BCQ6vT0J2erqu8kWd.png"}
```

On OSX, viewing the site image looks like: 
```
$ open http://grub:f00bark@34.82.44.60:8983/images/1ORJX7BCQ6vT0J2erqu8kWd.png
```

## Tensorflow
Deploy a tensorflow model. This part remains to be completed, although there is a nice Tensorflow deployment here:

[Deploy Tensorflow in 10 Minutes](https://gist.github.com/kordless/c5b445447498ff5cb28178e12a7d9b0b)

Back in Grub-2.0's directory, do the following:

```
$ ./deploy-tensorflow.sh
Password token is: f00bark
```

## Fastener
Deploy a controller box for starting instances. Not done yet, either.

```
$ ./deploy-fastener.sh
```

Instance will be running in a few minutes listening on port 80.

## Bookmark
[Bookmark and index](https://mitta.us/https://github.com/kordless/grub-2.0/) this page using [Mitta.us](https://mitta.us/).

## Credits
*"Your ideas don't stink. Just make sure they become a reality."* - **Igor Stojanovski, Author of Grub**

Thanks, Igor. I forgot this for a time, but am keeping it "clearly in mind" now.
