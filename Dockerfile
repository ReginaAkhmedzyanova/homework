FROM ubuntu:20.04
RUN apt update
RUN apt install default-jdk -y
RUN apt install maven -y
RUN apt install tomcat9 -y
EXPOSE 8080
RUN apt install git -y
WORKDIR /home/regina/homework/
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello
WORKDIR /home/regina/homework/boxfuse-sample-java-war-hello
RUN mvn package 
RUN cp /home/regina/homework/boxfuse-sample-java-war-hello/target/hello-1.0.war /var/lib/tomacat9/webapps/
CMD ["catalina.sh", "run"]