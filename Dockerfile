FROM ubuntu:22.04

# https://nodejs.org/en/download/releases
ENV NODE_VERSION 18.18.0
# https://github.com/nvm-sh/nvm/releases
ENV NVM_VERSION v0.39.5

RUN     DEBIAN_FRONTEND=noninteractive apt-get update \
    &&  DEBIAN_FRONTEND=noninteractive apt-get install -y \
          curl \
          build-essential \
          libssl-dev

# Install NVM and NodeJS
RUN mkdir -p /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash
RUN /bin/bash -c "source ${NVM_DIR}/nvm.sh && nvm install ${NODE_VERSION} && nvm alias default ${NODE_VERSION} && nvm use default"
ENV NODE_PATH ${NVM_DIR}/versions/node/v${NODE_VERSION}/lib/node_modules
ENV PATH      ${NVM_DIR}/versions/node/v${NODE_VERSION}/bin:${PATH}

# Update NPM
RUN npm install -g npm@latest

# Install packages
RUN npm install -g @ocular-d/vale-bin

# Project Setup
RUN mkdir /opt/project
WORKDIR /opt/project


