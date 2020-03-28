FROM dmoj-base:latest

WORKDIR /online-judge

ENTRYPOINT celery -A dmoj_celery worker -l info --concurrency=2
