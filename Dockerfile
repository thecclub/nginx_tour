FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y  git curl
RUN mkdir /home/c_club
ADD scripts /home
RUN echo "echo \"Hello,  Welcome\"" >> /root/.bashrc
ENV PROMPT_COMMAND="${PROMPT_COMMAND} source /home/state_checker.sh"
RUN chmod 777 /home/state_checker.sh /home/source_state_checker.sh
ENV tour_state="start"
RUN precmd() { source /home/state_checker.sh; }
EXPOSE 80
CMD ["/bin/bash"]
