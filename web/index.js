const luaInteropWorker = new Worker('lua-interop-worker.js');

const runLuaScript = () => {
    const luaScript = document.getElementById('script_area').value
    luaInteropWorker.postMessage({name: 'run-lua', body: luaScript})
}

const handleScriptResult = (result) => {
    document.getElementById('result_area').innerHTML = result
}

const messageHandlers = {
    'lua-runner-ready': runLuaScript,
    'lua-script-evaluated': handleScriptResult,
}

luaInteropWorker.onmessage = ({data: {name, body}}) => {
    const logUndefinedHandler = () => console.error(`No handler defined for ${name} in main`);

    (messageHandlers[name] || logUndefinedHandler)(body)
}

const onRunClick = () => {
    runLuaScript()
}
