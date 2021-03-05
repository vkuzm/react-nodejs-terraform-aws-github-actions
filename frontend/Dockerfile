FROM node:alpine as builder

ARG API_URL

WORKDIR '/app'
COPY package.*json .
RUN npm install
COPY . .
RUN REACT_APP_API_URL=$API_URL npm run build

FROM nginx
EXPOSE 80
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build/ /usr/share/nginx/html/