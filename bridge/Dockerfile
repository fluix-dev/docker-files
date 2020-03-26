FROM python:buster
ENV PYTHONBUFFERED 1

RUN apt update && apt install -y git
RUN git clone https://github.com/DMOJ/online-judge.git
WORKDIR /online-judge
RUN git submodule init
RUN git submodule update

RUN pip install -r requirements.txt
RUN pip install mysqlclient
RUN pip install git+https://github.com/TheAvidDev/django-discord-integration.git#egg=django-discord-integration
RUN pip install websocket-client

COPY local_settings.py /online-judge/dmoj

EXPOSE 9999
EXPOSE 9998

CMD ["python","manage.py","runbridged"]
