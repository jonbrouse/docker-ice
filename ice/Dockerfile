#FROM jonbrouse/java:7
FROM openjdk:8u131-jdk-alpine
MAINTAINER Jon Brouse @jonbrouse

ENV INSTALL_DIR /opt/ice
ENV HOME_DIR /root
ENV GRAILS_VERSION 2.4.4
ENV GRAILS_HOME ${HOME_DIR}/.grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}
ENV PATH $PATH:${HOME_DIR}/.grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}/bin/
ENV ICE_VERSION 0.0

ARG JAVA_OPTS

WORKDIR ${HOME_DIR}

# Install required software
RUN \
  apk --update add bash curl tar unzip && \
  rm -rf /var/cache/apk/* && \
  mkdir -p ${INSTALL_DIR} && \
  mkdir -p .grails/wrapper/${GRAILS_VERSION} && \
  curl -o .grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}.zip http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/grails-${GRAILS_VERSION}.zip && \
  unzip .grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}.zip -d .grails/wrapper/${GRAILS_VERSION} && \
  rm -rf .grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}.zip

WORKDIR ${INSTALL_DIR} 

# Ice setup
RUN \
  mkdir -p /mnt/ice_processor && \
  mkdir -p /mnt/ice_reader
#RUN curl -L https://github.com/Teevity/ice/archive/${ICE_VERSION}.tar.gz | tar -zx -C /opt/ice --strip 1
RUN curl -O https://github.com/Teevity/ice/archive/${ICE_VERSION}.tar.gz && tar -zx ${ICE_VERSION}.tar.gz -C /opt/ice --strip-components=1

RUN grails ${JAVA_OPTS} wrapper && \
    rm grails-app/i18n/messages.properties

RUN sed -i -e '1i#!/bin/bash\' grailsw

EXPOSE 8080

ENTRYPOINT ["/opt/ice/grailsw"]

CMD []
