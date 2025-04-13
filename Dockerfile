# Step1: Build React App
FROM node:alpine3.20 as build
WORKDIR /app
COPY package.json .
RUN pnpm install
COPY . .
RUN pnpm run build

# Step 2: Server With Nginx
FROM nginx:1.27-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /app/build .
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]