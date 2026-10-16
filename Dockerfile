# Estágio 1: Build da aplicação React/Vite
FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# Estágio 2: Servidor Web Nginx leve para servir os arquivos
FROM nginx:alpine

# Copia a build do React para a pasta pública do Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Copia as configurações personalizadas do Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]