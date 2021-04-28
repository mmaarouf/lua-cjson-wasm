const runLuaScript = () => {
    const luaScript = document.getElementById('script_area').value
    luaInteropWorker.postMessage({name: 'run-lua', body: luaScript})
}

const initPage = () => {
    document.getElementById('script_area').innerHTML = "return 'hello world'"
    runLuaScript()
}

const handleScriptResult = ({result, data}) => {
    const resultTextarea = document.getElementById('result_area')
    result_area.className = result === 'ok' ? 'success' : 'error'
    resultTextarea.innerHTML = data
}

const messageHandlers = {
    'lua-runner-ready': initPage,
    'lua-script-evaluated': handleScriptResult,
}

const luaInteropWorker = new Worker('lua-interop-worker.js');

luaInteropWorker.onmessage = ({data: {name, body}}) => {
    const logUndefinedHandler = () => console.error(`No handler defined for ${name} in main`);

    (messageHandlers[name] || logUndefinedHandler)(body)
}

const onRunClick = () => runLuaScript()

const onScriptKeyUp = (e) => {
    const controlEnter = e.keyCode === 13 && e.ctrlKey
    if (controlEnter)
        runLuaScript();
}
