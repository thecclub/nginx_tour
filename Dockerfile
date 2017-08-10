FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y  git curl nano vim wget
RUN wget https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.8.3.linux-amd64.tar.gz
ENV GOPATH="/root/.go"
ENV PATH="$PATH:/usr/local/go/bin:$GOPATH/bin/"
RUN go get github.com/yudai/gotty
RUN mkdir /home/c_club
ADD scripts /home
RUN echo "echo \"Hello,  Welcome\"" >> /root/.bashrc
ENV PROMPT_COMMAND="${PROMPT_COMMAND} source /home/state_checker.sh"
RUN chmod 777 /home/state_checker.sh /home/source_state_checker.sh
ENV tour_state="start"
ENV number_of_trials=0
RUN precmd() { source /home/state_checker.sh; }
EXPOSE 80
CMD ["/bin/bash"]
