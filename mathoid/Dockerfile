FROM node:8.17.0

RUN apt-get update && \
    apt-get install -y librsvg2-dev mocha git

RUN npm install mathoid && \
    ln -sfv /node_modules/mathoid/app.js /node_modules/app.js

COPY config.yaml /node_modules/mathoid/

EXPOSE 10044
WORKDIR /node_modules/mathoid
CMD /node_modules/mathoid/server.js
