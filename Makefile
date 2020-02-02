DOCKER_NAME=hexo
DOCKER_TAG=debina10
VOLUME_DIR=/tmp/${DOCKER_NAME}-${DOCKER_TAG}
PORT=4000

USER_NAME=klemen
USER_ID=1000
USER_PASSWORD=klemen
GROUP_NAME=klemen
GROUP_ID=1000

all: build run

volume:
	mkdir -p ${VOLUME_DIR}

volume_clean:
	rm -rf ${VOLUME_DIR}

build:
	docker build \
		--build-arg USER_ID=${USER_ID} \
		--build-arg USER_NAME=${USER_NAME} \
		--build-arg USER_PASSWORD=${USER_PASSWORD} \
		--build-arg GROUP_ID=${GROUP_ID} \
		--build-arg GROUP_NAME=${GROUP_NAME} \
		-t ${DOCKER_NAME}:${DOCKER_TAG} .

run: volume
	docker run --rm -it -p ${PORT}:4000 -v ${VOLUME_DIR}:/mnt/data --hostname=${DOCKER_NAME}-${DOCKER_TAG} ${DOCKER_NAME}:${DOCKER_TAG}

clean: volume_clean
	docker image rm ${DOCKER_NAME}:${DOCKER_TAG}
