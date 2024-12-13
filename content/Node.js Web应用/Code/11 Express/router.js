const express = require("express")
const app = express()

app.get("/user/:id", (req, res) => {
  res.send(`Hello ${req.params.id}`)
})

app.get("/user/admin:admin(\d+)", (req, res) => {
  res.send(`Hello Admin${req.params.admin}`)
})

app.listen(8000, () => {
  console.info("Listening")
})