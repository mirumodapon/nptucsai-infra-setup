.PHONY: up down create_networks remove_networks

NETWORKS=proxy

up:
	@$(MAKE) create_networks
	@docker compose -f **/docker-compose.yml up -d

down:
	@docker compose -f **/docker-compose.yml down
	@$(MAKE) remove_networks

create_networks:
	@for network in $(NETWORKS); do \
		if ! docker network inspect $${network} > /dev/null 2>&1; then \
			echo "Creating network: $${network}"; \
			docker network create $${network}; \
			echo ""; \
		else \
			echo "Network already exists: $${network}"; \
		fi; \
	done

remove_networks:
	@for network in $(NETWORKS); do \
		if docker network inspect $${network} > /dev/null 2>&1; then \
			echo "Removing network: $${network}"; \
			docker network rm $${network} > /dev/null 2>&1; \
		fi; \
	done
