const fs = require("fs");

let data = fs.readFileSync("./input.txt");

console.log(data.toString());
console.log("I am blocked :( ")