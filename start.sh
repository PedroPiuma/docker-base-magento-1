#!/usr/bin/env bash

if docker compose version &> /dev/null; then
  DOCKER_COMPOSE="docker compose"
elif docker-compose version &> /dev/null; then
  DOCKER_COMPOSE="docker-compose"
else
  echo "Nenhum comando docker compose ou docker-compose encontrado. Certifique-se de que o Docker Compose está instalado."
  exit 1
fi

$DOCKER_COMPOSE up -d && \
echo "
===================== 🚀 Done 🚀 ===================

      Criado por Luís Pedro Piúma
      
      Access your new links:

      🌎 Web server: http://localhost/
      ⚙️ PHPMyAdmin: http://localhost:8080
      ✉️ Local emails: http://localhost:8025

===================== 🚀 Done 🚀 ==================="
