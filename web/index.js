var Module = {
  print: text => console.log(text),
  printErr: text => console.error(text),
  onRuntimeInitialized: () => console.log("ready"),
};

const runLua = (code) => {
  return Module.ccall("runLua", 'string', ['string'], [code]);
}
