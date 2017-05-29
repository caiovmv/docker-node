FROM node:6.10.3

RUN apt-get update && apt-get upgrade -y

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD ARG NODE_ENV
ONBUILD ENV NODE_ENV $NODE_ENV
ONBUILD COPY src/* /usr/src/app/
#ONBUILD RUN npm install && npm cache clean
#ONBUILD COPY . /usr/src/app

CMD [ "npm", "start" ]
