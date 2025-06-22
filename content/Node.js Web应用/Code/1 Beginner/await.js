const fs = require("fs/promises");

(async () => {
  let data = await fs.readFile("./input.txt");

  console.log(data.toString());

  console.log("I am blocked because of await! ");
})()
