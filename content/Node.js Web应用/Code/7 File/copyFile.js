const fs = require("node:fs/promises")

const copy = async (from, to) => {
  let data = await fs.readFile(from)
  fs.writeFile(to, data)
}

module.exports = {
  copy
}