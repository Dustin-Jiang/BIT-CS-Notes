const events = require("events");
const eventEmitter = new events.EventEmitter();

eventEmitter.on("a", () => {
  console.log("Get event a!");
})

eventEmitter.on("b", (val) => {
  console.log("Get event b! Value is: " + val);
})

eventEmitter.emit("a");
eventEmitter.emit("b", "Hello");