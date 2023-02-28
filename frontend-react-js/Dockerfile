ARG NODE_IMAGE=node
ARG NODE_VERSION=16.18
FROM ${NODE_IMAGE}:${NODE_VERSION} as node_builder

ENV PORT=3000

WORKDIR /app

# We copy over the package.json files to take advantage of dockers caching
# When we copy & install first, we are creating an intermediate image since we
# are using the RUN command, that image will be cached, so as long as our dependencies
# dont change it can use this cached version to save time while still being up to date on
# anything that changed.
COPY package*.json ./
RUN npm install

# Now that all the node modules are cached, we can copy over the rest of the things
COPY . .

FROM ${NODE_IMAGE}:${NODE_VERSION} as frontend_dev
WORKDIR /frontend-react-js

COPY --chown=node:node --from=node_builder /app/package*.json ./
COPY --chown=node:node --from=node_builder /app/node_modules ./node_modules
COPY --chown=node:node --from=node_builder /app/src ./src
COPY --chown=node:node --from=node_builder /app/public ./public

EXPOSE ${PORT}
CMD ["npm", "start"]