FROM node:16 AS build-stage

WORKDIR /usr/src/app

COPY . . 

RUN npm ci

RUN npm run build

# This is a new stage, everything before this will be gone, except the files we want to COPY

FROM nginx:1.20-alpine

# COPY the directory build from build-stage to /usr/share/nginx/html
# The target location here was found from the nginx docker hub page

COPY --from=build-stage /usr/src/app/build /usr/share/nginx/html
