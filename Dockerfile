# build stage
FROM registry.access.redhat.com/ubi9/nodejs-20 AS build

WORKDIR /app

# copy source
COPY . .

# FIX PERMISSION
RUN chown -R 1001:0 /app && chmod -R g+rwX /app

# install & build
RUN npm ci && npm run build


# runtime stage
FROM registry.access.redhat.com/ubi9/nginx-124

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 8080