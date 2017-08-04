FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y  git
RUN mkdir /home/c_club
ADD scripts /home
RUN echo "echo \"Hello,  Welcome\"" >> /root/.bashrc
RUN cat "/home/scripts/state_checker.sh"
RUN ["/bin/bash", "PROMPT_COMMAND+=\"/home/scripts/state_checker.sh;\"" ]
EXPOSE 80
CMD "/bin/bash"
