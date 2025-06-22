const fs = require("node:fs/promises")

fs.readFile("./test.txt").then((data) => {
  console.log(data)
  console.log(data.toString())
})