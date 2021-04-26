const luaInteropWorker = new Worker("lua-interop-worker.js");

const onLuaRunnerReady = () => {
    luaInteropWorker.postMessage({name: 'run-lua', body: 'print "hi"; return 5'})
}

const messageHandlers = {
    'lua-runner-ready': onLuaRunnerReady,
}

luaInteropWorker.onmessage = ({data: {name, body}}) => {
    const logUndefinedHandler = () => console.error(`No handler defined for ${name} in main`);

    (messageHandlers[name] || logUndefinedHandler)(body)
}
