# lua-cjson-wasm ![pipeline](https://github.com/mmaarouf/lua-cjson-wasm/actions/workflows/pipeline.yml/badge.svg)

Project to demo executing lua code that dynamically loads a dynamically loads a shared library (lua-cjson) in the browser using WebAssembly.

![demo](/demo.gif)

[Try it out here](https://mmaarouf.github.io/lua-cjson-wasm/).

## How it works

* When play button is clicked, the lua script is passed to [`lua_interop`](/lua-interop/lua_interop.c)
* `lua_interop` will use [`runner.lua`](/lua-runner/src/runner.lua) to execute the script
* `runner.lua` will wrap the script's return value in a "result" table, serialise it JSON using the [lua-cjson](https://github.com/openresty/lua-cjson/) library and then return it back to `lua_interop`
* `lua_interop` will pass the result back to the webpage
* The webpage will parse the JSON and display the result on the screen with green-ish/red-ish highlighting based on the result status

### Compiling the WebAssembly modules

Using the cjson library in the lua code dynamically loads it at runtime. To get this to work in WASM, it needs to be compiled as a `SIDE_MODULE`.

#### Compilation steps

1. Compile `lua` as a WASM side module
1. Compile `lua-cjson` into a WASM side module & rename atrifact to `cjson.so` to allow the lua runtime to dynamically load it at runtime
1. Compile `lua-interop.c` into a WASM main module

## Development

### Tools

* bash on linux-like environment (for Windows use WSL2)
* Docker
* Docker Compose
* An [`.editorconfig`](https://editorconfig.org/) compliant editor

### Commands

Main project commands:

* `./bin/build` - builds the project
* `./bin/run` - runs the project. Webpage accessible on port `8080`
* `./bin/shell` - shells into the development environment
* `./bin/clean` - deletes compiled artifacts

To run the project: `./bin/build && ./bin/run`

#### Development environment commands

When running commands under `./bin/` a new ephemeral docker container is spun up to execute the command.

Alternatively you can start single container and have it run in the background using `./bin/dev-env/start`.
That allows you to do things such as have the project running in one terminal, and be `shell`ed into the development environment in another.

To stop, use: `./bin/dev-env/stop`.
