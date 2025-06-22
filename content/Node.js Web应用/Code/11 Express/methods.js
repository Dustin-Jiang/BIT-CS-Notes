const express = require("express")
const path = require("node:path")

const app = express()

app.get("/", (req, res) => {
  res.send("Hello GET")
})

app.post("/", (req, res) => {
  res.send("Hello POST");
});

app.put("/", (req, res) => {
  res.send("Hello PUT");
});

app.delete("/", (req, res) => {
  res.send("Hello DELETE");
});

app.head("/", (req, res) => {
  res.send("Hello HEAD");
});

app.patch("/", (req, res) => {
  res.send("Hello PATCH");
});

app.options("/", (req, res) => {
  res.send("Hello OPTIONS");
});

app.all("/", (req, res, next) => {
  res.send("Hello All")
  next()
})

app.listen(8000, () => {
  console.info("Listening")
})