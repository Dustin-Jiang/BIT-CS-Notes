const fs = require("fs/promises");

fs.readFile("./input.txt").then((data) => {
  console.log(data.toString());
}, (err) => {
  throw err;
});

console.log("I am not blocked lol")