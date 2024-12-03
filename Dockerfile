# Build stage
FROM node:lts as builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Production stage
FROM node:lts

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/.nuxt ./.nuxt
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/nuxt.config.ts ./

EXPOSE 3000

CMD ["npm", "run", "dev"]