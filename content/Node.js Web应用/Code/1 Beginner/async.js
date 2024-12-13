const fs = require("fs")

fs.readFile("./input.txt", (err, data) => {
  if (err) throw err;
  console.log(data.toString());
})

console.log("I am not blocked! ")