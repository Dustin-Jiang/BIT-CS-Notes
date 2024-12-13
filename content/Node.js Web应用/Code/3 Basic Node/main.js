const counter = require("./counter")

let c1 = new counter.Counter()
let c2 = new counter.Counter(15)

console.log(c1.value)
console.log(c2.value)

console.log(c1.value)
console.log(c1.value)
console.log(c2.value)