ARG APP_PATH=/opt/outline
FROM node:18-alpine

ARG APP_PATH
ARG CDN_URL

WORKDIR $APP_PATH

COPY . .

ENV NODE_ENV production

RUN yarn install --no-optional --frozen-lockfile --network-timeout 1000000 && \
  yarn build && \
  addgroup -g 1001 -S nodejs && \
  adduser -S nodejs -u 1001 && \
  chown -R nodejs:nodejs $APP_PATH/build

USER nodejs

EXPOSE 3000
CMD ["yarn", "start"]
