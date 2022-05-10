import os
import re
import time

import datetime
import logging

import requests
import urllib
import json

import sys

from selenium import webdriver
from selenium.webdriver.chrome.options import Options

from flask import Flask, render_template, make_response, request, abort, send_from_directory

# app up
app = Flask(__name__)


# main route
@app.route('/g', methods=['POST'])
def grub():
	# url, upload_url and user_token from appengine
	url = request.form.get('url')
	upload_url = request.form.get('upload_url')
	api_token = request.form.get('api_token')
	sidekick_name = request.form.get('sidekick_name')
	doc_id = request.form.get('doc_id')

	if not url or not upload_url or not api_token:
		abort(404, "not found")

	# don't allow any quotes in the URL
	if '"' in url or "'" in url:
		abort(404, "not found")

	# set options
	chrome_options = Options()
	chrome_options.add_argument('--no-sandbox')
	chrome_options.add_argument('--disable-dev-shm-usage')
	chrome_options.add_argument('--headless')

	# create the driver and connect to page
	driver = webdriver.Chrome('./chromedriver', chrome_options=chrome_options)
	driver.get(url)

	# set the window up to full height
	size = driver.get_window_size()
	width = driver.execute_script('return document.body.parentNode.scrollWidth')
	height = driver.execute_script('return document.body.parentNode.scrollHeight')
	driver.set_window_size(width, height)

	# set the output and screenshot
	filename = "%s.png" % random_string(23)
	el = driver.find_element_by_tag_name('body')
	el.screenshot("./images/%s" % filename)
	
	# upload to the spool endpoint
	url = "%s?token=%s&sidekick_name=%s&document_id=%s" % (upload_url, api_token, sidekick_name, doc_id) 
	files = [('images', (filename, open("./images/%s" % filename.rstrip('\r\n'), 'rb'), 'image/png'))]
	response = requests.request("POST", url, files = files)

	# write some logs
	file_object = open('./logs/mitta_upload.log', 'a')
	file_object.write(response.text)
	file_object.close()

	return make_response(response.json())


@app.route('/h', methods=['GET'])
def health_check():
	return "OK"


@app.errorhandler(404)
def f404_notfound(e):
	logging.info("here")
	return "404 not found <a href='/'>exit</a>", 404


@app.errorhandler(500)
def server_error(e):
	# handle a 404 too!
	logging.exception('An error occurred during a request.')
	return "An error occured and this is the fail.".format(e), 500


if __name__ == '__main__':
	app.run(host='0.0.0.0', port=7070, debug=True)
