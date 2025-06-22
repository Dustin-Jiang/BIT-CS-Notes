const fs = require("node:fs")

let data = fs.readFileSync("./test.txt")

console.log(data)
console.log(data.toString())