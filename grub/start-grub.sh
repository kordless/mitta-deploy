#!/bin/bash

while true; do
  cd /opt/mitta-deploy/grub/
  gunicorn -w 5 -b 127.0.0.1:7070 grub:app
done

