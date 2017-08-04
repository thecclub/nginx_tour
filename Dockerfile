FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y  git
RUN mkdir /home/c_club
ADD scripts /home
RUN echo "echo \"Hello,  Welcome\"" >> /root/.bashrc
RUN chmod 777 /home/state_checker.sh /home/source_state_checker.sh
ENV PROMPT_COMMAND="${PROMPT_COMMAND}/home/source_state_checker.sh;"
ENV tour_state="start"
EXPOSE 80
CMD "/bin/bash"
