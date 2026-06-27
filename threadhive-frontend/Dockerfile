# ThreadHive frontend — React 19 + Vite SPA, served as static files by nginx.

# ---- Build stage: compile the SPA to static assets ----
FROM node:22-alpine AS build

WORKDIR /app

# Install deps first for layer caching (lockfile present -> use npm ci)
COPY package.json package-lock.json ./
RUN npm ci

# API base URL is inlined into the bundle at build time.
# Override with: docker build --build-arg VITE_API_BASE_URL=https://api.example.com/api
ARG VITE_API_BASE_URL
ENV VITE_API_BASE_URL=$VITE_API_BASE_URL

# Build the production bundle into /app/dist
COPY . .
RUN npm run build

# ---- Serve stage: nginx serves the static build ----
FROM nginx:alpine

# Custom server config: listen on 3000 + SPA history fallback
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the compiled assets from the build stage
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]
