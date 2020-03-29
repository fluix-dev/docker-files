FROM dmoj-base:latest

RUN pip install uwsgi
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt-get update && apt-get install -y nodejs
RUN npm install -g sass postcss-cli autoprefixer

WORKDIR /online-judge

EXPOSE 8001

ENTRYPOINT ["uwsgi","--ini","uwsgi.ini"]
