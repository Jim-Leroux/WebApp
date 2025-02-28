FROM nginx:alpine

RUN apk add --no-cache nodejs npm

COPY ./app /usr/share/nginx/html

WORKDIR /usr/share/nginx/html

RUN npm install

CMD ["npm", "test"]
