FROM jonbrouse/java:7
MAINTAINER Jon Brouse @jonbrouse

ENV INSTALL_DIR /opt/ice
ENV HOME_DIR /root
ENV GRAILS_VERSION 2.4.4
ENV GRAILS_HOME ${HOME_DIR}/.grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}
ENV PATH $PATH:${HOME_DIR}/.grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}/bin/

WORKDIR ${HOME_DIR}

# Install required software
RUN \
  apt-get update && \
  apt-get install -y unzip && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir -p ${INSTALL_DIR} && \
  mkdir -p .grails/wrapper/${GRAILS_VERSION} && \
  curl -o .grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}.zip http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/grails-${GRAILS_VERSION}.zip && \
  unzip .grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}.zip -d .grails/wrapper/${GRAILS_VERSION} && \
  rm -rf .grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}.zip

WORKDIR ${INSTALL_DIR} 

# Ice setup
RUN \
  mkdir /mnt/ice_processor && \
  mkdir /mnt/ice_reader && \
  curl https://codeload.github.com/Netflix/ice/tar.gz/master | tar -zx -C /opt/ice --strip 1 && \
  grails ${JAVA_OPTS} wrapper && \
  rm grails-app/i18n/messages.properties && \ 
  sed -i -e '1i#!/bin/bash\' grailsw

EXPOSE 8080

ENTRYPOINT ["/opt/ice/grailsw"]

CMD []
