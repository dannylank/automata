# Stage 1: Build the Angular application
FROM node:16.14 AS build

WORKDIR /app

# Copia el archivo package.json y package-lock.json
COPY package*.json ./

# Instala Angular CLI globalmente y las dependencias
RUN npm install -g @angular/cli@16 \
    && npm install --legacy-peer-deps

# Copia el código fuente de la aplicación
COPY . .

# Compila la aplicación Angular
#RUN ng build --watch --configuration development 
#--configuration=production

# Stage 2: Create an Nginx server to serve the Angular app
#FROM nginx:alpine

# Copia los archivos de construcción al directorio de Nginx
#COPY --from=build /app/dist/demo1 /usr/share/nginx/html

# Exponer el puerto 80 para servir la aplicación
EXPOSE 4200

# Comando para iniciar Nginx en segundo plano
#CMD ["nginx", "-g", "daemon off;"]
CMD ["ng", "serve", "--host", "0.0.0.0", "--port", "4200"]
