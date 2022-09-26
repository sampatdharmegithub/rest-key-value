
APP_NAME := rest-api-app
TAG := $(shell git rev-parse --abbrev-ref HEAD | sed 's/[^a-zA-Z0-9]/-/g')
APP_IMG := ${APP_NAME}:${TAG}

.PHONY: build push tests

build:
	docker build . -t ${APP_NAME}
	docker tag ${APP_NAME} ${registry}/${repo}/${APP_IMG}

push:
	docker push ${registry}/${repo}/${APP_IMG}

tests:
	docker-compose up -d
	npm run test
	docker-compose down
