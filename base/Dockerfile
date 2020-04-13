FROM python:slim
ENV PYTHONBUFFERED 1

RUN apt-get update && apt-get install -y git curl gcc g++ make gettext sed libmariadbclient-dev fontconfig

RUN pip install redis
RUN pip install mysqlclient
RUN pip install websocket-client

COPY repo/requirements.txt .
RUN pip install -r requirements.txt
