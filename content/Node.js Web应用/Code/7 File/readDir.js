const fs = require("node:fs/promises")

fs.readdir("./").then((value) => {
  for (let item of value) {
    console.log(item)
  }
})