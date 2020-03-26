FROM python:buster
ENV PYTHONBUFFERED 1

RUN apt update && apt install -y git curl gcc g++ make gettext sed
RUN git clone https://github.com/DMOJ/online-judge.git
WORKDIR /online-judge
RUN git submodule init
RUN git submodule update
RUN curl -L https://gist.githubusercontent.com/TheAvidDev/4b9394e948869ccf8117703dc288c6ef/raw/29681cb75b0cbd49ba09e64b6208018027e283b9/py | git apply

RUN pip install -r requirements.txt
RUN pip install mysqlclient
RUN pip install uwsgi
RUN pip install git+https://github.com/TheAvidDev/django-discord-integration.git#egg=django-discord-integration
RUN pip install websocket-client

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt update && apt install -y nodejs
RUN npm install -g sass postcss-cli autoprefixer

COPY local_settings.py /online-judge/dmoj
COPY uwsgi.ini /online-judge

EXPOSE 8001

CMD ["uwsgi","--ini","uwsgi.ini"]
