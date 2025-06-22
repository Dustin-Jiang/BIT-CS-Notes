const hello = require("./hello")
const world = require("./world")

const main = () => {
  hello.hello()
  world.world()
}

module.exports = {
  main
}