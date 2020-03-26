FROM debian:buster
RUN apt update
RUN apt install -y wget tar curl bzip2
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN tar -xvf phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN mv phantomjs-2.1.1-linux-x86_64 phantomjs
RUN rm phantomjs-2.1.1-linux-x86_64.tar.bz2

#RUN curl -L https://raw.githubusercontent.com/mrbvrz/segoe-ui-linux/master/install.sh -o install.sh
#RUN chmod +x install.sh
#RUN ls -l
#RUN install.sh

WORKDIR /phantomjs
