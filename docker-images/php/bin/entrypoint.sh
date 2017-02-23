#!/bin/bash
set -e

service cron start

docker-php-entrypoint "$@"
