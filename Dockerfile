FROM node:16-alpine as builder
USER node
RUN mkdir -p /home/node/app
WORKDIR '/home/node/app'
COPY --chown=node:node ./package.json ./
RUN npm i
COPY --chown=node:node ./ ./
RUN npm run build

FROM nginx as runner
COPY --from=builder /home/node/app/build /usr/share/nginx/html
# De bovengenoemde /usr folder is de folder die de image verwacht de HTML te vinden
