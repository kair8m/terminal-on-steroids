rebuild:
	docker compose build

run:
	docker compose run dev-container

attach:
	docker compose exec -it dev-container /bin/zsh
