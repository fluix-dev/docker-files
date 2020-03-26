FROM python:buster
ENV PYTHONBUFFERED 1

RUN apt update && apt install -y git curl gcc g++ make
RUN git clone https://github.com/DMOJ/online-judge.git
WORKDIR /online-judge
RUN git submodule init
RUN git submodule update

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt update && apt install -y nodejs
RUN npm install qu ws simplesets
RUN pip install websocket-client

EXPOSE 15100
EXPOSE 15101
EXPOSE 15102

COPY config.js /online-judge/websocket

CMD ["node","websocket/daemon.js"]
