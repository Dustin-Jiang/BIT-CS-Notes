const fs = require("fs");

let data = fs.readFileSync("./input.txt");

console.log(data.toString());
console.log("I am blocked :( ");

const fsPromise = require("fs/promises");

(async () => {
  let data = await fsPromise.readFile("./input.txt");

  console.log(data.toString());

  console.log("I am blocked because of await! ");
})();
