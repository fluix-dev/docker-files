#!/bin/sh
docker-compose run --rm --entrypoint "python manage.py migrate" dmoj
