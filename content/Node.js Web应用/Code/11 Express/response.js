const express = require("express")
const app = express()
const path = require("node:path")

app.get("/download", (req, res) => {
  res.download("./test.txt")
})

app.get("/info/:id", (req, res) => {
  res.json({
    id: req.params.id
  })
})

app.get("/info/:username", (req, res) => {
  res.jsonp({
    username: req.params.username
  })
})

app.get("/redirect", (req, res) => {
  res.redirect("/")
})

app.get("/sendFile/:name", (req, res) => {
  let options = {
    root: path.join(__dirname, "public"),
    dotfiles: "deny",
    headers: {
      "x-timestamp": Date.now(),
      "x-sent": true
    }
  }

  res.sendFile(req.params.name, options, (err) => {
    if (err) throw err
  })
})

app.listen(8000, () => {
  console.info("Listening")
})