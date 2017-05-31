FROM debian:latest

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git bash ftp telnet wget curl build-essential gcc g++ make autoconf

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD src/package.tar /usr/src/app/

RUN npm cache clean
RUN npm install

CMD [ "npm", "start" ]

