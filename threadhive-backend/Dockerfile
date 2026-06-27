# ThreadHive backend — Express 5 + MongoDB/Mongoose REST API
FROM node:22-alpine

# All app files live here
WORKDIR /usr/src/app

# Install production dependencies first so this layer is cached
# unless package.json changes. (No package-lock.json in this project,
# so we use `npm install` rather than `npm ci`.)
COPY package.json ./
RUN npm install --omit=dev

# Copy the rest of the source. The .env file is excluded via
# .dockerignore — env vars are injected at runtime with `--env-file`.
COPY . .

# Make the startup script executable (seeds the DB, then starts the server)
RUN chmod +x docker-entrypoint.sh

# Default the port to 8080. The injected env file can still override it.
ENV PORT=8080
EXPOSE 8080

# Drop root privileges (the base image ships a `node` user)
USER node

# Seeds MongoDB (unless SEED_DB=false) and then runs `node main.js`
ENTRYPOINT ["./docker-entrypoint.sh"]
