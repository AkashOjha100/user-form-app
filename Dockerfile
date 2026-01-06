# ---------- Build Stage ----------
FROM node:18-alpine AS build

WORKDIR /app

# Copy package files first (important for caching)
COPY package*.json ./

# Install dependencies
RUN npm install --include=dev

# Copy source code
COPY . .

# Build React app
RUN npm run build


# ---------- Production Stage ----------
FROM nginx:alpine

# Copy build output to nginx
COPY --from=build /app/build /usr/share/nginx/html

# Expose port (CORRECT FORMAT)
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
 
