# Stage 1: Node.js-Basisimage zum Bauen der App
FROM node:lts-alpine as build-stage

# Arbeitsverzeichnis im Container festlegen
WORKDIR /react-tetris

# Abhängigkeiten installieren
COPY package*.json ./
RUN npm ci

# Quellcode kopieren
COPY . .

# Anwendung bauen
RUN npm run build

# Stage 2: Nginx zum Ausführen der App
FROM nginx:alpine as production-stage

# Nginx Konfigurationsdatei kopieren (optional, falls angepasst)
# COPY nginx.conf /etc/nginx/nginx.conf

# Build-Artefakte aus der Build-Stage in das Verzeichnis des Nginx-Webservers kopieren
COPY --from=build-stage /react-tetris/dist /usr/share/nginx/html

# Port 80 freigeben rrgrhtm, fgerge

EXPOSE 80

# Nginx im Vordergrund laufen lassen
CMD ["nginx", "-g", "daemon off;"]
