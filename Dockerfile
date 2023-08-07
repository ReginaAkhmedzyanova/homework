FROM ubuntu:20.04

ENV TOMCAT_VERSION 9.0.78
ENV CATALINA_HOME /usr/local/tomcat
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
ENV PATH $CATALINA_HOME/bin:$PATH
ENV DEBIAN_FRONTEND=noninteractive 

RUN apt update 
RUN apt install git -y
RUN apt install wget -y 
RUN apt install default-jdk -y
RUN apt install maven -y

RUN mkdir $CATALINA_HOME
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-${TOMCAT_VERSION}/* $CATALINA_HOME
RUN rm -rf /tmp/apache-tomcat-${TOMCAT_VERSION}
RUN rm -rf /tmp/tomcat.tar.gz

WORKDIR /home/regina/homework/
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello
WORKDIR /home/regina/homework/boxfuse-sample-java-war-hello
RUN mvn package 
RUN cp /home/regina/homework/boxfuse-sample-java-war-hello/target/hello-1.0.war /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]