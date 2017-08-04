FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y  git
ADD scripts /
EXPOSE 80
CMD "/bin/bash"
