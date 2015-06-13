FROM jonbrouse/docker-java:7
MAINTAINER Jon Brouse

ENV INSTALL_DIR /opt/ice
ENV HOME_DIR /root
ENV GRAILS_VERSION 2.4.4
ENV GRAILS_HOME ${HOME_DIR}/.grails/wrapper/grails-${GRAILS_VERSION}
ENV PATH $PATH:${HOME_DIR}/.grails/wrapper/grails-${GRAILS_VERSION}/bin/
#ENV JAVA_OPTS

WORKDIR ${HOME_DIR}

# Install required software
RUN \
  apt-get update && \
  apt-get install -y git unzip && \
  mkdir -p ${INSTALL_DIR} && \
  mkdir -p {.grails/wrapper/,ice_processor,ice_reader} && \
  curl -o .grails/wrapper/grails-${GRAILS_VERSION}.zip http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/grails-${GRAILS_VERSION}.zip && \
  unzip .grails/wrapper/grails-${GRAILS_VERSION}.zip -d .grails/wrapper/ && \
  rm -rf .grails/wrapper/grails-${GRAILS_VERSION}.zip && \

WORKDIR ${INSTALL_DIR}
  
# Ice setup
RUN \
  git clone https://github.com/Netflix/ice.git . && \
  grails ${JAVA_OPTS} wrapper && \
  rm grails-app/i18n/messages.properties && \ 
  rm -rf /var/lib/apt/lists/*

COPY assets/ice.properties src/java/ice.properties
  
ENTRYPOINT ["/opt/ice/grailsw"]

CMD []
