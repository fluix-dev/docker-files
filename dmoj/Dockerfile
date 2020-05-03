FROM dmoj-base:latest

RUN pip install uwsgi selenium
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt-get update && apt-get install -y nodejs chromium=80.0.3987.162-1 unzip
RUN npm install -g sass postcss-cli autoprefixer

RUN wget https://chromedriver.storage.googleapis.com/80.0.3987.106/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip
RUN install chromedriver /usr/local/bin/
RUN rm chromedriver_linux64.zip chromedriver

WORKDIR /online-judge

EXPOSE 8001

ENTRYPOINT ["uwsgi","--ini","uwsgi.ini"]
