VERSION ?= 0.12.2.1
OS = linux
ARCH := $(shell uname -m)

dist/wkhtmltox-$(VERSION)-$(OS)-$(ARCH).tar.xz:
	docker buildx build --progress plain --output type=local,dest=dist $(VERSION)
