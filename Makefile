up:
	docker compose up -d
build:
	docker compose build
down:
	docker compose down
web:
	docker compose exec web bash
db:
	docker compose exec db bash
