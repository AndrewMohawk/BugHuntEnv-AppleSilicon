#!/bin/bash

# Get the current user's UID and GID
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)

echo "Starting container with USER_ID=$USER_ID and GROUP_ID=$GROUP_ID"

# Rebuild and start the container with correct permissions
docker compose down
docker compose build
docker compose up -d

echo "Container started. You can now connect with:"
echo "docker compose exec bughunt-env bash"