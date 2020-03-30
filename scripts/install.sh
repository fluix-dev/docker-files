#!/bin/sh
docker-compose run --rm --entrypoint "/bin/sh -c '\
        python manage.py migrate && \
        python manage.py loaddata language_small && \
        python manage.py loaddata navbar && \
        python manage.py loaddata demo'" dmoj
