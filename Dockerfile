FROM node:latest as build

WORKDIR /app
COPY app app
COPY public public
COPY package-lock.json .
COPY package.json .
COPY next.config.mjs .

RUN npm install
RUN npm run build

FROM nginx
COPY --from=build /app/out /usr/share/nginx/html
