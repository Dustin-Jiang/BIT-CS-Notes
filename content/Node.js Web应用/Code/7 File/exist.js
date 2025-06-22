const fs = require("node:fs/promises")

fs.access("test.txt", fs.constants.F_OK).then(() => {
  console.log("exists")
}).catch(() => {
  console.log("not found")
})