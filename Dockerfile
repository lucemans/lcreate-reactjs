FROM node:latest as builder

WORKDIR /app

RUN npm i -g parcel-bundler typescript @types/react @types/react-dom

COPY package*.json ./

RUN npm ci

COPY . ./

RUN npm run build

FROM nginx:stable-alpine
COPY --from=builder /app/dist/* /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
