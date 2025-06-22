const fs = require("node:fs/promises")

fs.stat("./test.txt").then((val) => {
  console.log(val)

  console.log(val.isFile())
  console.log(val.isDirectory())
  console.log(val.isBlockDevice());
  console.log(val.isCharacterDevice());
  console.log(val.isSymbolicLink());
  console.log(val.isSocket());
})