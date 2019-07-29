FROM node:11-alpine as node
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package.json /usr/src/app
RUN npm install
COPY . /usr/src/app
RUN npm run build -- --prod

FROM nginx:latest
VOLUME /var/cache/nginx
COPY --from=node /usr/src/app/dist/browser /usr/share/nginx/dist/
COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf
