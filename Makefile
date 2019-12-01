 
# REQUIRED SECTION
ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
include $(ROOT_DIR)/.mk-lib/common.mk
# END OF REQUIRED SECTION

SUPPORTED_COMMANDS := run
SUPPORTS_MAKE_ARGS := $(findstring $(firstword $(MAKECMDGOALS)), $(SUPPORTED_COMMANDS))
ifneq "$(SUPPORTS_MAKE_ARGS)" ""
  COMMAND_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  COMMAND_ARGS := $(subst :,\:,$(COMMAND_ARGS))
  $(eval $(COMMAND_ARGS):;@:)
endif

.PHONY: help dependencies up start stop restart status ps clean

dependencies: check-dependencies ## Check dependencies

up: ## Start all or c=<name> containers in foreground
	@USER=${USER} $(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up $(c)

start: ## Start all or c=<name> containers in background
	@USER=${USER} $(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d $(c)

stop: ## Stop all or c=<name> containers
	@USER=${USER} $(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) stop $(c)

restart: ## Restart all or c=<name> containers
	@USER=${USER} $(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) stop $(c)
	@USER=${USER} $(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up $(c) -d

logs: ## Show logs for all or c=<name> containers
	@USER=${USER} $(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) logs --tail=100 -f $(c)

status: ## Show status of containers
	@USER=${USER} $(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) ps

ps: status ## Alias of status

clean: confirm ## Clean all data
	@USER=${USER} $(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down

run :
	@USER=${USER} $(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) run $(COMMAND_ARGS)