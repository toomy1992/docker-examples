#!/bin/bash

WORKDIR=$PWD

echo "starting Compose"

cd $WORKDIR/compose

sudo docker-compose -f compose.yml up
