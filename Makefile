VERSION ?= 0.12.2.1

dist/wkhtmltox-$(VERSION).tar.xz:
	docker buildx build --output type=local,dest=dist $(VERSION)
