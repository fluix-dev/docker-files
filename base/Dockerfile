FROM python:buster
ENV PYTHONBUFFERED 1

RUN apt-get update && apt-get install -y git curl gcc g++ make gettext sed

RUN pip install redis
RUN pip install mysqlclient
RUN pip install git+https://github.com/TheAvidDev/django-discord-integration.git#egg=django-discord-integration
RUN pip install websocket-client

COPY repo/requirements.txt .
RUN pip install -r requirements.txt
