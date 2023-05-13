FROM node:14-alpine AS builder

# Add a work directory
WORKDIR /app
# Cache and Install dependencies
COPY package.json .

RUN npm install

# Copy app files
COPY . .

ENV NODE_ENV production

# Build the app
RUN yarn build

FROM nginx:1.21.0-alpine as production

ENV NODE_ENV production
# Copy built assets from builder
COPY --from=builder /app/build /usr/share/nginx/html

RUN ls -latr /usr/share/nginx/html
# Add your nginx.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
# Expose port
EXPOSE 80
# Start nginx
CMD ["nginx", "-g", "daemon off;"]

