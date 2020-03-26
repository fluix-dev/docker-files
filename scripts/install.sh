#!/bin/sh
cp ../dmoj/local_settings.py ../bridge/
docker-compose build --no-cache
docker-compose run --rm --entrypoint "python manage.py migrate" dmoj
docker-compose run --rm --entrypoint "python manage.py loaddata language_small" dmoj
docker-compose run --rm --entrypoint "python manage.py migrate" dmoj
docker-compose run --rm --entrypoint "python manage.py loaddata navbar" dmoj
docker-compose run --rm --entrypoint "python manage.py loaddata demo" dmoj
