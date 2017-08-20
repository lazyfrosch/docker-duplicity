
all: build push

build:
	docker pull ubuntu:xenial
	docker build --rm -t lazyfrosch/duplicity .

push:
	docker push lazyfrosch/duplicity
