
######################################################################################################
# build docker image:
#
# ref:
#   - https://stackoverflow.com/questions/45357771/stop-and-remove-all-docker-containers
#
######################################################################################################

build:
	docker build --file ./Dockerfile --tag "servicemesh/dockerfile:python-3.6.5" .


build.local:
	docker build --file ./Dockerfile.local --tag "servicemesh/dockerfile:python-local-3.6.5" .


clean:
	docker container prune --force
	docker image prune --force
	docker volume prune --force
	docker network prune --force
	# docker system prune --force
