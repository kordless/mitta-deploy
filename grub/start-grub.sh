#!/bin/bash

while true; do
  cd /opt/mitta-deploy/grub/
  gunicorn --worker-class=gevent --workers 5 --bind=127.0.0.1:7070 --timeout=60 grub:app
done


