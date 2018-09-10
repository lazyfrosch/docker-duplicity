FROM := $(shell grep FROM Dockerfile | cut -d" " -f2)
IMAGE := lazyfrosch/duplicity

default: build
all: build push

build:
	docker pull $(FROM)
	docker build --rm -t $(IMAGE) .

push:
	docker push $(IMAGE)
