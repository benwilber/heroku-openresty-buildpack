OPENRESTY_VERSION ?= 1.19.3.1
LUAROCKS_VERSION ?= 3.4.0

build: build-heroku-16 build-heroku-18 build-heroku-20

build-heroku-16:
	@echo "Building OpenResty in Docker for heroku-16 ..."
	@docker run -v $(shell pwd):/buildpack -w /buildpack --rm -it \
		 -e "STACK=heroku-16" -e "OPENRESTY_VERSION=$(OPENRESTY_VERSION)" -e "LUAROCKS_VERSION=$(LUAROCKS_VERSION)" \
		heroku/heroku:16-build bin/build /buildpack/dist/openresty-heroku-16.tar.gz

build-heroku-18:
	@echo "Building OpenResty in Docker for heroku-18 ..."
	@docker run -v $(shell pwd):/buildpack -w /buildpack --rm -it \
		 -e "STACK=heroku-18" -e "OPENRESTY_VERSION=$(OPENRESTY_VERSION)" -e "LUAROCKS_VERSION=$(LUAROCKS_VERSION)" \
		heroku/heroku:18-build bin/build /buildpack/dist/openresty-heroku-18.tar.gz

build-heroku-20:
	@echo "Building OpenResty in Docker for heroku-20 ..."
	@docker run -v $(shell pwd):/buildpack -w /buildpack --rm -it \
		 -e "STACK=heroku-20" -e "OPENRESTY_VERSION=$(OPENRESTY_VERSION)" -e "LUAROCKS_VERSION=$(LUAROCKS_VERSION)" \
		heroku/heroku:20-build bin/build /buildpack/dist/openresty-heroku-20.tar.gz

shell-heroku-16:
	@echo "Start a Docker shell for heroku-16 ..."
	@docker run -v $(shell pwd):/buildpack --rm -it -e "STACK=heroku-16" -w /buildpack heroku/heroku:16-build bash

shell-heroku-18:
	@echo "Start a Docker shell for heroku-18 ..."
	@docker run -v $(shell pwd):/buildpack --rm -it -e "STACK=heroku-18" -w /buildpack heroku/heroku:18-build bash


shell-heroku-20:
	@echo "Start a Docker shell for heroku-20 ..."
	@docker run -v $(shell pwd):/buildpack --rm -it -e "STACK=heroku-20" -w /buildpack heroku/heroku:20-build bash
