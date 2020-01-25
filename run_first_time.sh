#!/bin/bash

WORKDIR=$PWD

echo "Cloning Repository"

git clone https://github.com/skygate/app-example.git

echo "Preparing client side"

cd $WORKDIR/app-example/client
npm install

echo "Setting proxy from localhost to backend as container dns resolver"

sed -i "s/localhost:8080/backend:8080/g" package.json

echo "Preparing Server side"

cd $WORKDIR/app-example/server
npm install

echo "Preparing ngnix"

sudo mkdir $WORKDIR/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout  $WORKDIR/ssl/key.key -out  $WORKDIR/ssl/cert.crt -subj '/CN=localhost'
sudo openssl dhparam -out  $WORKDIR/ssl/dhparam.pem 2048

echo "starting Compose"

cd $WORKDIR/compose

sudo docker-compose -f compose.yml up
