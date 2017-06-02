FROM debian:latest

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git bash ftp telnet wget curl build-essential gcc g++ make autoconf keychain openssh-client

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

RUN rm -f ~/.ssh/known_hosts

COPY ./keys/id_rsa /usr/src/app 

RUN echo " StrictHostKeyChecking no"  >> /etc/ssh/ssh_config

RUN chmod 600 /usr/src/app/id_rsa
RUN ssh-agent bash -c 'ssh-add /usr/src/app/id_rsa; git clone git@bitbucket.org:AdminSesi/smarthealth.git'

WORKDIR /usr/src/app/smarthealth/health/frontend

#COPY src/package.tar /usr/src/app/
#RUN tar -xvf package.tar

RUN npm cache clean
RUN npm install

CMD [ "npm", "start" ]
#CMD [ "bash" ]
