FROM node:alpine

RUN npm init -y
RUN npm install qu ws simplesets

EXPOSE 15100
EXPOSE 15101
EXPOSE 15102

ENTRYPOINT ["node","/online-judge/websocket/daemon.js"]
