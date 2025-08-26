.PHONY: up down create_networks remove_networks

NETWORKS=proxy

up:
	@$(MAKE) create_networks
	@for compose in $$(ls **/docker-compose.yml); do \
		docker compose -f $${compose} up -d; \
	done

down:
	@for compose in $$(ls **/docker-compose.yml); do \
		docker compose -f $${compose} down; \
	done
	@$(MAKE) remove_networks

create_networks:
	@for network in $$(./list_networks.sh); do \
		if ! docker network inspect $${network} > /dev/null 2>&1; then \
			echo "Creating network: $${network}"; \
			docker network create $${network}; \
			echo ""; \
		else \
			echo "Network already exists: $${network}"; \
		fi; \
	done

remove_networks:
	@for network in $$(./list_networks.sh); do \
		if docker network inspect $${network} > /dev/null 2>&1; then \
			echo "Removing network: $${network}"; \
			docker network rm $${network} > /dev/null 2>&1; \
		fi; \
	done
