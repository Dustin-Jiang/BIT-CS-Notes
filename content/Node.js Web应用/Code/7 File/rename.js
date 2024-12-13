const fs = require("node:fs/promises")

fs.rename("./test2.txt", "./test3.txt").catch((e) => {
  throw e;
})