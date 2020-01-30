FROM debian:10

USER root
WORKDIR /root

RUN apt update \
 && apt install -y bash git vim neovim curl tmux vifm

RUN curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh \
 && bash nodesource_setup.sh \
 && apt update \
 && apt install -y nodejs \
 && npm install hexo-cli -g \
 && npm install

RUN mkdir -p /mnt/data

USER root
WORKDIR /mnt/data
VOLUME /mnt/data
EXPOSE 4000
ENTRYPOINT ["/bin/bash"]
