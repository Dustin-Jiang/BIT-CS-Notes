const fs = require("node:fs")

const rs = fs.createReadStream("./test.txt")
const ws = fs.createWriteStream("./test2.txt")

rs.on("data", (data) => {
  ws.write(data)
})

rs.on("error", () => { throw error })

rs.on("close", () => {
  ws.close()
})