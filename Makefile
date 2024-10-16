VERSION ?= 0.12.2.1

default: dist/wkhtmltox-$(VERSION)

build:
	docker buildx build --output type=local,dest=build $(VERSION)

dist/wkhtmltox-$(VERSION): build
	mkdir -p dist/
	cp -v build/wkhtmltox-$(VERSION).tar.xz dist/

.PHONY: default
