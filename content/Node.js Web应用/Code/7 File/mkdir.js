const fs = require("node:fs/promises")

fs.mkdir("./test").then(() => {
  console.log("successfully")
}).catch((e) => {
  throw e;
})