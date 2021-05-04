const getScriptTextArea = () => document.getElementById('script_area')

const getResultTextArea = () => document.getElementById('result_area')

const runLuaScript = () => {
    const scriptTextArea = getScriptTextArea()
    luaInteropWorker.postMessage({name: 'run-lua', body: scriptTextArea.value})

    scriptTextArea.className = 'loading'
}

const initPage = () => {
    const defaultScript = "local cjson = require 'cjson.safe'\n\n" +
        'local greeting = {\n' +
        "    hello = 'world'\n" +
        '}\n\n' +
        "return cjson.encode(greeting)"

    getScriptTextArea().innerHTML = defaultScript
    runLuaScript()
}

const handleScriptResult = ({result, data}) => {
    const resultTextArea = getResultTextArea()
    resultTextArea.className = result === 'ok' ? 'success' : 'error'
    resultTextArea.innerHTML = data

    getScriptTextArea().className = undefined
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
    if (controlEnter) {
        runLuaScript()
    }
}
