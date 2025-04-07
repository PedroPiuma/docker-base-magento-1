#!/usr/bin/env bash

if docker compose version &> /dev/null; then
  DOCKER_COMPOSE="docker compose"
elif docker-compose version &> /dev/null; then
  DOCKER_COMPOSE="docker-compose"
else
  echo "Nenhum comando docker compose ou docker-compose encontrado. Certifique-se de que o Docker Compose está instalado."
  exit 1
fi

if [ -z "$1" ]
  then
    $DOCKER_COMPOSE exec --user www-data apache bash
else
    $DOCKER_COMPOSE exec --user $@ apache bash
fi
