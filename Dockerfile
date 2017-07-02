FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git bash ftp telnet vim  wget curl build-essential gcc g++ make autoconf keychain openssh-client language-pack-en

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs net-tools 

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

RUN rm -f ~/.ssh/known_hosts

COPY ./keys/id_rsa /usr/src/app 

RUN echo " StrictHostKeyChecking no"  >> /etc/ssh/ssh_config

RUN chmod 600 /usr/src/app/id_rsa
RUN ssh-agent bash -c 'ssh-add /usr/src/app/id_rsa; git clone git@bitbucket.org:AdminSesi/smarthealth.git'

#WORKDIR /usr/src/app/smarthealth/health/frontend
#RUN echo "import { Injectable } from '@angular/core'; \
#import { Subject }    from 'rxjs/Subject'; \
#@Injectable() \
#export class ConfigUrl { \
#    URL_BASE='http://sshosting003.fiesc.com.br:8080/template/'; \
#} \
#" > src/app/config.ts 

#RUN rm -rf /usr/src/app/*
COPY src/package.tar /usr/src/app/
RUN tar -xvf package.tar

RUN npm cache clean
RUN npm install

ENV HOST 0.0.0.0
ENV PORT 80

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8
RUN locale-gen $LANG

CMD [ "npm", "start" ]
#CMD [ "/bin/bash" ]
