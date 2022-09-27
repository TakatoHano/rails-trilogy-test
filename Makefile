default: up

build_up: build up

up: migrate
	docker compose up -d web_app

init: create_db build up

migrate:
	docker compose up -d db
	docker compose run --rm web_app bundle exec rails db:migrate

create_db:
	docker compose up -d db
	sleep 5s
	docker compose run --rm web_app bundle exec rails db:create

build:
	docker compose build
