const fs = require("fs");

fs.readFile("./input.txt", (err, data) => {
  if (err) throw err;
  console.log(data.toString());
});

console.log("I am not blocked! ");

const fsPromise = require("fs/promises");

fsPromise.readFile("./input.txt")
.then((data) => {
  console.log(data.toString());
}, (err) => {
  throw err;
});

console.log("I am not blocked lol");