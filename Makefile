DOCKER_NAME=hexo
DOCKER_TAG=debina10
VOLUME_DIR=/tmp/${DOCKER_NAME}-${DOCKER_TAG}

all: build run

volume:
	mkdir -p ${VOLUME_DIR}

volume_clean:
	rm -rf ${VOLUME_DIR}

build:
	docker build -t ${DOCKER_NAME}:${DOCKER_TAG} .

run:
	docker run --rm -it -v ${VOLUME_DIR}:/mnt/data ${DOCKER_NAME}:${DOCKER_TAG}

clean: volume_clean
	docker image rm ${DOCKER_NAME}:${DOCKER_TAG}
