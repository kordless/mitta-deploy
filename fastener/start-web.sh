#!/bin/bash

mkdir -v keys
export GOOGLE_APPLICATION_CREDENTIALS="/mitta-deploy/mitta-us.json"
screen -dmS fastener bash -c "bash do-web.sh"
