#!/bin/bash

docker-compose run --rm php magerun --skip-root-check --root-dir="/var/www/html/web" $@
