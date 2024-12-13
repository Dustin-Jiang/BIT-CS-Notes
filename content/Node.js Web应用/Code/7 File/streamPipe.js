const fs = require("node:fs")

const rs = fs.createReadStream("test.txt")
const ws = fs.createWriteStream("test2.txt")

rs.pipe(ws)