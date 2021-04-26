OUT_DIR= out/
CJSON_TARGET= TARGET='cjson.wasm'
LUA_TARGET= LUA_T='lua.wasm' LUAC_T='luac.wasm'
INCLUDE_LUA= -I/lua-5.1.5/src
WASMC= emcc -s WASM=1

all: out-dir lua.wasm cjson.wasm lua_interop.wasm webpage

out-dir:
	mkdir -p $(OUT_DIR)

lua.wasm:
	cd /lua-5.1.5/src && \
	make generic CC='$(WASMC) -DLUA_USE_DLOPEN -s SIDE_MODULE=1' $(LUA_TARGET)

cjson.wasm:
	cd /lua-cjson && \
        make CC='$(WASMC) -s SIDE_MODULE=1 -s EXPORT_ALL=1 $(INCLUDE_LUA)' $(CJSON_TARGET)
	cp /lua-cjson/cjson.wasm out/cjson.so

lua_interop.wasm:
	$(WASMC) $(INCLUDE_LUA) -O2 \
         -s MAIN_MODULE=1 \
         -s "EXTRA_EXPORTED_RUNTIME_METHODS=['ccall']" \
         --preload-file $(OUT_DIR)@/ \
         lua-interop/lua_interop.c /lua-5.1.5/src/liblua.a \
         -o ${OUT_DIR}lua-interop.js

webpage:
	cp -rp ./web/* $(OUT_DIR)

clean:
	rm -rf out/
	cd /lua-5.1.5/src && make clean $(LUA_TARGET)
	cd /lua-cjson && make clean $(CJSON_TARGET)
