# Stage 1: Build the Angular application
FROM node:latest AS build

WORKDIR /app

# Copia el archivo package.json y package-lock.json
COPY package*.json ./

# Instala Angular CLI globalmente y las dependencias
RUN npm install -g @angular/cli && npm install --legacy-peer-deps

# Copia el código fuente de la aplicación
COPY . .

# Compila la aplicación Angular
RUN ng build --configuration=production

# Stage 2: Create an Nginx server to serve the Angular app
FROM nginx:alpine

# Copia los archivos de construcción al directorio de Nginx
COPY --from=build /app/dist/demo1 /usr/share/nginx/html

# Exponer el puerto 80 para servir la aplicación
EXPOSE 80

# Comando para iniciar Nginx en segundo plano
CMD ["nginx", "-g", "daemon off;"]
