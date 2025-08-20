NAME = b2bwebid/shiny-server
VERSION = 1.5.23.1030

.PHONY: all build tag_latest release

all: build

download:
	wget https://download3.rstudio.org/ubuntu-20.04/x86_64/shiny-server-$(VERSION)-amd64.deb

build:
	docker build -t $(NAME):$(VERSION) --rm .

clean:
	rm shiny-server-$(VERSION)-amd64.deb

tag_latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest
	docker push $(NAME):latest

tag_version:
	docker tag $(NAME):$(VERSION) $(NAME):buster
	docker push $(NAME):buster

release: tag_latest tag_version
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "Build image first."; false; fi
	docker push $(NAME):$(VERSION)
