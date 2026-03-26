# Antigravity Manager - Docker Lifecycle Makefile
# This Makefile targets the Headless/Relay server version of the project.

COMPOSE_FILE = docker/docker-compose.yml
PROJECT_NAME = antigravity-manager

.PHONY: help build up down stop logs shell ps clean restart

# --- Help ---
help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

# --- Docker Lifecycle ---
build: ## Build the Docker image from source (all jobs in container)
	docker compose -f $(COMPOSE_FILE) build

up: ## Start the container in detached mode (plus build if modified)
	docker compose -f $(COMPOSE_FILE) up -d --build

down: ## Stop and remove containers, networks, and images
	docker compose -f $(COMPOSE_FILE) down

stop: ## Stop the running container without removing it
	docker compose -f $(COMPOSE_FILE) stop

restart: ## Restart the running container
	docker compose -f $(COMPOSE_FILE) restart

# --- Observation ---
logs: ## Follow the live logs of the container
	docker compose -f $(COMPOSE_FILE) logs -f

ps: ## View current container status
	docker compose -f $(COMPOSE_FILE) ps

shell: ## Open a shell inside the running container (for debugging)
	docker exec -it $(PROJECT_NAME) /bin/bash

# --- Utilities ---
clean: ## Remove dangling images and unused build caches
	docker system prune -f
	docker volume prune -f
