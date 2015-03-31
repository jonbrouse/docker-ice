FROM ubuntu:14.04
MAINTAINER Jon Brouse

ENV HOME_DIR /opt
ENV GRAILS_VERSION 2.4.4
ENV GRAILS_HOME ${HOME_DIR}/.grails/wrapper/${GRAILS_VERSION}
ENV JAVA_VERSION openjdk-7-jdk
ENV PATH $PATH:${HOME_DIR}/.grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}/bin/
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
#ENV JAVA_OPTS

WORKDIR ${HOME_DIR}

RUN \
  apt-get update && \
  apt-get install -y git ${JAVA_VERSION} wget unzip && \
  mkdir -p .grails/wrapper/${GRAILS_VERSION} && \
  wget http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/grails-${GRAILS_VERSION}.zip -P ${HOME_DIR}/.grails/wrapper/ && \
  unzip ${HOME_DIR}/.grails/wrapper/grails-${GRAILS_VERSION}.zip -d ${HOME_DIR}/.grails/wrapper/${GRAILS_VERSION}/ && \
  rm -rf ${HOME_DIR}/.grails/wrapper/grails-${GRAILS_VERSION}.zip && \
  git clone https://github.com/Netflix/ice.git && \
  grails ${JAVA_OPTS} wrapper && \
  rm grails-app/i18n/messages.properties && \ 
  mkdir {ice_processor,ice_reader} && \
  rm -rf /var/lib/apt/lists/*
  

# TODO
# Customize /opt/ice/src/java/ice.properties
# AWS S3 BILLBUCKET & PROCBUCKET  
# 
# Write script to accept AWS creds and
# start grailsw run-app
