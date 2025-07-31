# WeasyRb Docker Development Scripts

## Build and test
build-and-test:
	docker-compose build
	docker-compose run test

## Interactive development shell
dev:
	docker-compose run weasy_rb bash

## Ruby console
console:
	docker-compose run console

## Run tests
test:
	docker-compose run test

## Run linter
lint:
	docker-compose run weasy_rb bundle exec rubocop

## Clean up Docker resources
clean:
	docker-compose down
	docker system prune -f

## Rebuild from scratch
rebuild:
	docker-compose down
	docker-compose build --no-cache
	docker-compose run test

.PHONY: build-and-test dev console test lint clean rebuild
