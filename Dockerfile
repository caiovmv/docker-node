FROM node:6.10.3

RUN apt-get update && apt-get upgrade -y

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD src/package.tar /usr/src/app/

RUN npm cache clean
RUN npm install

CMD [ "npm", "start" ]

