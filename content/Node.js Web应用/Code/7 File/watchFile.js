const fs = require("node:fs")

let watch = fs.watch("test.txt")

watch.addListener("change", (type, file) => {
  console.log(file, type)
})