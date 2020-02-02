FROM debian:10

ARG USER_ID=1000
ARG USER_NAME=klemen
ARG GROUP_ID=1000
ARG GROUP_NAME=klemen
ARG USER_HOME=/home/${USER_NAME}
ARG USER_PASSWORD=klemen

USER root
WORKDIR /root

# Update, upgrade and install needed programs
RUN apt update \
 && apt upgrade -y \
 && apt install -y bash zsh git vim neovim curl tmux vifm openssl

# Install nodejs and hexo-cli
RUN curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh \
 && bash nodesource_setup.sh \
 && apt update \
 && apt upgrade -y \
 && apt install -y nodejs \
 && npm install hexo-cli -g \
 && npm install

# Create a group and user
RUN groupadd -g ${GROUP_ID} ${GROUP_NAME} \
 && useradd -m -d ${USER_HOME} -u ${USER_ID} -g ${GROUP_ID} -s /bin/bash -c 'Hexo user' -p $(openssl passwd -6 -salt debian10 "${USER_PASSWORD}") ${USER_NAME}

# Create shared dir
RUN mkdir -p /mnt/data \
 && chown -R ${USER_ID}:${GROUP_ID} /mnt/data

USER ${USER_NAME}
WORKDIR /mnt/data

VOLUME /mnt/data
EXPOSE 4000

ENTRYPOINT ["/bin/bash"]
