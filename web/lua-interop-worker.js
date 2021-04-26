/**
 * The lua code dynamically loads up the lua-cjson library at which point
 * Chromea complains that loading up a library that is greater then 4kb is not allowed on the
 * main thread as it blocks it.
 * Therefore using web workers to load and execute the wasm module functions.
 */
var Module = {
    print: text => console.log(text),
    printErr: text => console.error(text),
    onRuntimeInitialized: () => postMessage({name: 'lua-runner-ready'}),
};

const runLua = (code) => {
    return Module.ccall("runLua", 'string', ['string'], [code]);
}

const messageHandlers = {
    'run-lua': runLua
}

onmessage = ({data: {name, body}}) => {
    console.log(name)
    console.log(body)
    const logUndefinedHandler = () => console.error(`No handler defined for ${name} in worker`);

    (messageHandlers[name] || logUndefinedHandler)(body)
}

self.importScripts('lua-interop.js')
