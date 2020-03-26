#!/bin/sh
docker-compose build --no-cache
docker-compose run --rm --entrypoint "python manage.py migrate" dmoj
