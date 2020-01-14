FROM openjdk:alpine
MAINTAINER Jon Brouse @jonbrouse

ENV INSTALL_DIR /opt/ice
ENV HOME_DIR /root
ENV GRAILS_VERSION 2.4.4
ENV GRAILS_HOME ${HOME_DIR}/.grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}
ENV PATH $PATH:${HOME_DIR}/.grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}/bin/

ARG JAVA_OPTS

WORKDIR ${HOME_DIR}/.grails/wrapper/${GRAILS_VERSION}

# Install required software
RUN apk add --no-cache bash curl unzip && \
    curl -O http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/grails-${GRAILS_VERSION}.zip && \
    unzip grails-${GRAILS_VERSION}.zip && \
    rm -rf grails-${GRAILS_VERSION}.zip

WORKDIR ${INSTALL_DIR} 

# Ice setup
RUN mkdir /mnt/ice_processor /mnt/ice_reader && \
    curl -fsSLO https://github.com/jimroth/ice/archive/master.zip && \
    unzip master.zip && \
    mv ice-master/* . && \
    rm -rf master.zip ./ice-master

RUN grails ${JAVA_OPTS} wrapper && \
    rm grails-app/i18n/messages.properties && \
    sed -i -e '1i#!/bin/bash\' grailsw

EXPOSE 8080

ENTRYPOINT ["/opt/ice/grailsw"]

CMD []
