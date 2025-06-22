const fs = require("node:fs")
let ws = fs.createWriteStream("test.txt")

ws.write("test", "utf-8")

ws.on("finish", () => console.log("finish"))
ws.on("error", (error) => { throw error })

ws.close()