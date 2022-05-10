#!/bin/bash
TYPE=e2-medium
ZONE=us-west1-c
NEW_UUID=$(LC_ALL=C tr -dc 'a-z0-9' </dev/urandom | head -c 4 ; echo)
NAME=grub

option=$1
PREEMPTIBLE="--preemptible"
# IP="--address=34.82.44.60"
UBUNTU_VERSION="ubuntu-1804-bionic-v20220118"

echo "This instance is preemtible, unless it's started with --prod";
case $option in
    -p|--prod|--production)
    unset PREEMPTIBLE
	echo "Production mode enabled..."
    echo;
    IP=""
esac

if [ -f secrets.sh ]; then
   source secrets.sh # truly, a travesty, sets TOKEN=token-[passphrase]
   echo "Here's where I say, hold on a second while we fire things up."
   gcloud compute project-info add-metadata --metadata token=$TOKEN
   echo;
else
   echo "Create 'secrets.sh', put a TOKEN=f00bar statement in it and then rerun this script."
   echo;
   exit;
fi

gcloud compute firewall-rules create fastener-api --allow tcp:8383

SCRIPT=$(cat <<EOF
#!/bin/bash
sudo su -

apt-get update -y
apt-get install unzip -y
apt-get install build-essential -y
apt-get install python-dev -y
apt-get install python-setuptools -y
apt-get install python3-pip -y
apt-get install -y libappindicator1 fonts-liberation
apt-get install apache2-utils -y
apt-get install nginx -y

pip3 install --upgrade pip
pip3 install flask
pip3 install urllib3
pip3 install httplib2
pip3 install requests
pip3 install gunicorn
pip3 install setuptools

apt-get update -y

mkdir -p /opt
cd /opt/
git clone https://github.com/kordless/mitta-deploy.git

mkdir -p /opt/temp
cd /opt/temp/

curl https://storage.googleapis.com/mitta-deploy/chromedriver.zip > chromedriver.zip
dpkg -i google-chrome*.deb
sudo apt-get install -f

curl https://storage.googleapis.com/mitta-deploy/google-chrome_amd64.deb > google-chrome_amd64.deb
unzip chromedriver.zip
mv chromedriver /opt/mitta-deploy/grub/

  
cd /opt/mitta-deploy/grub/
cp nginx.conf.grub /etc/nginx/nginx.conf

python3 get_token.py grub

source bidntoken
echo $TOKEN >> /root/token

systemctl restart nginx.service

echo "starting grub"

EOF
)

gcloud compute instances create $NAME-$NEW_UUID \
--machine-type $TYPE \
--image "$UBUNTU_VERSION" \
--image-project "ubuntu-os-cloud" \
--boot-disk-size "10GB" \
--boot-disk-type "pd-ssd" \
--boot-disk-device-name "$NEW_UUID" \
--service-account mitta-us@appspot.gserviceaccount.com \
--scopes https://www.googleapis.com/auth/cloud-platform \
--zone $ZONE \
--labels type=grub \
--tags mitta,grub,token-$TOKEN \
$PREEMPTIBLE \
--subnet=default $IP --network-tier=PREMIUM \
--metadata startup-script="$SCRIPT"
sleep 15

IP=$(gcloud compute instances describe $NAME-$NEW_UUID --zone $ZONE  | grep natIP | cut -d: -f2 | sed 's/^[ \t]*//;s/[ \t]*$//')

echo "Server started with $IP. Use the SSH button to login."