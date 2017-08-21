FROM jonbrouse/java:7
MAINTAINER Jon Brouse @jonbrouse

ENV INSTALL_DIR /opt/ice
ENV HOME_DIR /root
ENV GRAILS_VERSION 2.4.4
ENV GRAILS_HOME ${HOME_DIR}/.grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}
ENV PATH $PATH:${HOME_DIR}/.grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}/bin/
ENV ICE_VERSION 1.1.1

ARG JAVA_OPTS

WORKDIR ${HOME_DIR}

# Install required software
RUN \
  curl -Lo unzip.deb http://http.us.debian.org/debian/pool/main/u/unzip/unzip_6.0-16+deb8u3_amd64.deb && \
  dpkg -i unzip.deb && \
  mkdir -p ${INSTALL_DIR} && \
  mkdir -p .grails/wrapper/${GRAILS_VERSION} && \
  unzip /root/grails-${GRAILS_VERSION}.zip -d .grails/wrapper/${GRAILS_VERSION} && \
  rm -rf unzip.deb ${GRAILS_VERSION}/grails-${GRAILS_VERSION}.zip

WORKDIR ${INSTALL_DIR} 

# Ice setup
RUN \
  mkdir /mnt/ice_processor && \
  mkdir /mnt/ice_reader && \
  curl -L https://github.com/Teevity/ice/archive/v${ICE_VERSION}.tar.gz | tar -zx -C /opt/ice --strip 1 && \
  grails ${JAVA_OPTS} wrapper && \
  rm grails-app/i18n/messages.properties && \ 
  sed -i -e '1i#!/bin/bash\' grailsw

EXPOSE 8080

ENTRYPOINT ["/opt/ice/grailsw"]

CMD []
