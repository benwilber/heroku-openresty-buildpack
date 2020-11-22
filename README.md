# OpenResty Buildpack for Heroku
(and Heroku-compatibles like [Dokku](http://dokku.viewdocs.io/dokku/))

## Features
* Support for the full OpenResty suite including [OPM](https://opm.openresty.org/) and the [Resty CLI](https://openresty.org/en/resty-cli.html)
* Built-in support for installing packages from [LuaRocks](https://luarocks.org/)
* Full control of the top-level `nginx.conf` and the `$LUA_PATH`/`$LUA_CPATH` environment variables
* Easily declare Lua dependencies by listing them in `opm.txt` and/or `luarocks.txt` in your project's root directory

## Getting started

The easiest way to get started with this buildpack is to check out the [Hello World](https://github.com/benwilber/heroku-openresty-hello-world.git) app.

### Basic usage

Clone the Hello World app

```bash
$ git clone https://github.com/benwilber/heroku-openresty-hello-world.git
$ cd heroku-openresty-hello-world
```

Create a new Heroku app

```bash
$ heroku apps:create --stack=heroku-20 --buildpack=https://github.com/benwilber/heroku-openresty-buildpack.git
```

We have to add the `heroku/python` buildpack as well so that we can compile the `nginx.conf` template.

```bash
$ heroku buildpacks:add heroku/python
```
Push the app to Heroku

```bash
$ git push heroku master
```

Visiting the app's URL in your web browser will display "Hello Lapis!"

## Supported Heroku stacks

This buildpack has been tested with the following Heroku stacks:

* `heroku-16`
* `heroku-18`
* `heroku-20`

## Building OpenResty

If you're interested in making a custom build of OpenResty then take a look at the [Makefile](Makefile) in the root of this repository.  OpenResty (and dependencies) are compiled in Docker running the target stack.

```bash
$ make build-heroku-20
```

You can modify the `bin/build` file to add or modify how OpenResty is built.  For instance, if you want to add additional NGINX modules.



