NAME = b2bwebid/shiny-server
VERSION = 20210801

.PHONY: all build tag_latest release

all: build

download:
	wget -c https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.16.958-amd64.deb

build:
	docker build -t $(NAME):$(VERSION) --rm .

clean:
	rm shiny-server-1.5.16.958-amd64.deb

tag_latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest
	docker push $(NAME):latest

tag_version:
	docker tag $(NAME):$(VERSION) $(NAME):buster
	docker push $(NAME):buster

release: tag_latest tag_version
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "Build image first."; false; fi
	docker push $(NAME):$(VERSION)
