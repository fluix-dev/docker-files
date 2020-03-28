FROM python:buster
ENV PYTHONBUFFERED 1

RUN apt-get update && apt-get install -y git curl gcc g++ make gettext sed

RUN pip install mysqlclient
RUN pip install uwsgi
RUN pip install websocket-client

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt-get update && apt install -y nodejs
RUN npm install -g sass postcss-cli autoprefixer

COPY repo/requirements.txt .
RUN pip install -r requirements.txt
