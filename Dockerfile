FROM node:20-alpine3.17 AS builder

WORKDIR /usr/app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build


FROM node:20-alpine3.17

WORKDIR /usr/app

COPY package*.json ./
RUN npm install --omit=dev

COPY --from=builder /usr/app/dist ./dist

EXPOSE 3000

CMD ["node", "dist/main"]