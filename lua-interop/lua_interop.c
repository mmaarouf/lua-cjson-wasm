#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <lauxlib.h>
#include <lualib.h>
#include <emscripten/emscripten.h>

const char* copyString(const char* toCopy) {
    char* newstr = (char*) malloc(strlen(toCopy) + 1);

     if (newstr) {
         strcpy(newstr, toCopy);
     }
     return newstr;
}

EMSCRIPTEN_KEEPALIVE
const char* runLua(const char* script) {
    lua_State* lua = luaL_newstate();
    luaL_openlibs(lua);

    luaL_dostring(lua, script);

    size_t len = 0;
    const char* result = lua_tostring(lua, -1);//, &len);

    // making a copy because large strings get freed on the `lua_close(lua)` call.
    const char* copyOfResult = copyString(result);

    lua_close(lua);

    return copyOfResult;
}
