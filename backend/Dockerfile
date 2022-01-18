FROM ubuntu:18.04
LABEL maintainer="Yeison Gimenez <yeisongimz@gmail.com>"
# Set environment variables and default password for user 'admin' 
ENV GLASSFISH_PKG=glassfish-5.0.1.zip \
 GLASSFISH_URL=https://download.oracle.com/glassfish/5.0/release/glassfish-5.0.zip \
 GLASSFISH_HOME=/glassfish5 \
 PATH=$PATH:/glassfish5/bin 
 #JAVA_HOME=/usr/lib/jvm/jdk1.8.0_291 \
 #DB_NAME=ecologiadb \
 #DB_USER=ecoverde \
 #DB_PASS=ecoverde.2021 \
 #DS_NAME=jdbc/ecologia \
 #db=172.18.0.2

# copiar jdk y otros archivos necesarios
COPY ./jdk-8u291-linux-x64.tar.gz /jdk-8u291-linux-x64.tar.gz
COPY ./postgresql-42.2.16.jar /postgresql-42.2.16.jar
COPY ./grizzly-npn-bootstrap.jar /grizzly-npn-bootstrap.jar
# Install packages, download and extract GlassFish 
# Setup password file \
# Enable DAS 
RUN apt-get update && apt-get upgrade && \
 apt-get install -y curl && \
 apt-get install -y unzip && \
 curl -O $GLASSFISH_URL && \
 unzip -o $GLASSFISH_PKG && \
 rm -rf $GLASSFISH_PKG && \
 mkdir /usr/lib/jvm/ && \
 tar -zxvf ./jdk-8u291-linux-x64.tar.gz -C /usr/lib/jvm/ && \
 update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_291/bin/java 1

 
# ACA EMPIEZA LO NUESTRO
RUN mv ./postgresql-42.2.16.jar $GLASSFISH_HOME/glassfish/domains/domain1/lib/postgresql.jar
RUN mv -f ./grizzly-npn-bootstrap.jar $GLASSFISH_HOME/glassfish/modules/endorsed/grizzly-npn-bootstrap.jar

#COPY ./war/ecologia-verde.war /war/ecologia-verde.war


RUN ls -la /
COPY /war/start.sh /war/
RUN chmod +x /war/start.sh

#cambiar zona horaria
RUN ln --force -s /usr/share/zoneinfo/America/Asuncion /etc/localtime

ENTRYPOINT ["sh", "/war/start.sh"]

