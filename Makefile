OUT_DIR= out/
LUA_TARGET= LUA_T='lua.wasm' LUAC_T='lua.wasm'
WASMC= emcc -s WASM=1

all: out-dir lua.wasm

out-dir:
	mkdir -p $(OUT_DIR)

lua.wasm:
	cd /lua-5.1.5/src && \
		make generic CC='$(WASMC) -DLUA_USE_DLOPEN' $(LUA_TARGET)

clean:
	rm -rf out/
	cd /lua-5.1.5/src && make clean $(LUA_TARGET)
