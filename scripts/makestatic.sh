#!/bin/sh
docker-compose run --rm --no-deps --entrypoint "/bin/sh -c '\
        ./make_style.sh && \
        python manage.py collectstatic --no-input && \
        python manage.py compilemessages && \
        python manage.py compilejsi18n'" dmoj
