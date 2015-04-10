#!/bin/bash

docker-compose stop
docker-compose rm --force
rm -rf web/* db logs vendor
