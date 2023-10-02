docker:
	docker-compose build --pull

shell:
	docker-compose run --rm --user="`id -u`:`id -g`" app bash

sync:
	vale sync

check:
	vale documents

run:
	make sync
	make check
