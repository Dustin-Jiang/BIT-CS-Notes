const fs = require("node:fs/promises")

const walkDir = (path) => {
  fs.readdir(path).then((val) => {
    for (let item of val) {
      console.log(path + item)

      fs.stat(path + item).then((val) => {
        if (val.isDirectory()) {
          walkDir(`${path}${item}/`)
        }
      })
    }
  })
}

walkDir("../")