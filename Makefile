oidc_server_container=wk-oidc-server

install:
	cd ./scripts && bash ./main.sh init_cfg

init-uc:
	docker-compose exec ${oidc_server_container} bash -c "make init"
	docker-compose exec ${oidc_server_container} bash -c "python manage.py loaddata oidc-server-outline-client"

start: install
	docker-compose up -d

restart:
	docker-compose stop
	docker-compose up -d

logs:
	docker-compose logs -f

stop:
	docker-compose down || true

update-images:
	docker-compose pull

clean-docker: stop
	docker-compose rm -fsv || true

clean-conf:
	rm -rfv env.* .env docker-compose.yml config/uc/fixtures/*.json

clean-data:
	rm -rfv ./data/certs ./data/minio_root ./data/pgdata ./data/uc

clean: clean-docker clean-conf
