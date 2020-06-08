FROM node:10.21.0-alpine

RUN apk update && apk upgrade && apk add --no-cache bash git

RUN npm i npm -g

WORKDIR /opt/service

COPY package.json ./

RUN npm install && npm install --global gulp-cli bower

COPY bower.json ./

RUN bower install --allow-root

CMD [ "gulp", "develop" ]
