#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <lauxlib.h>
#include <lualib.h>
#include <emscripten/emscripten.h>

const char* SCRIPT_TEMPLATE = "return require('runner').run([=====[ %s ]=====])";

const char* copyString(const char* toCopy) {
    char* newstr = (char*) malloc(strlen(toCopy) + 1);
     if (newstr) {
         strcpy(newstr, toCopy);
     }
     return newstr;
}

EMSCRIPTEN_KEEPALIVE
const char* runLua(const char* script) {
    const int scriptLen = strlen(SCRIPT_TEMPLATE) + strlen(script);
    char fullScript[scriptLen];
    sprintf(fullScript, SCRIPT_TEMPLATE, script);

    lua_State* lua = luaL_newstate();
    luaL_openlibs(lua);

    luaL_dostring(lua, fullScript);

    const char* result = lua_tostring(lua, -1);

    // allocate string on heap
    const char* copyOfResult = copyString(result);

    lua_close(lua);
    return copyOfResult;
}
