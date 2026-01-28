# build stage
FROM registry.access.redhat.com/ubi9/nodejs-20 AS build
WORKDIR /app
COPY . .
RUN npm ci && npm run build

# runtime stage
FROM registry.access.redhat.com/ubi9/nginx-124
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 8080