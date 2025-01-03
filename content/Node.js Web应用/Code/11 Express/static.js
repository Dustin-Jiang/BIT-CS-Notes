const express = require("express")
const path = require("node:path")

const app = express()
app.use(express.static(path.join(__dirname, "public")))

app.listen(8000, () => {
  console.info("Listen on port 8000")
})