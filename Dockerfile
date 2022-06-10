FROM node:16

# Installing libvips-dev for sharp compatability

RUN apt-get -y update && apt-get -y install libvips-dev

WORKDIR /opt/
COPY ./package.json ./
COPY ./yarn.lock ./
ENV PATH /opt/node_modules/.bin:$PATH
RUN yarn config set network-timeout 600000 -g
RUN yarn add pg
RUN yarn install

WORKDIR /opt/app
COPY ./ .
RUN yarn build
EXPOSE 1337