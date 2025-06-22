const os = require("node:os")

console.log(`OS: ${os.platform()}`)
console.log(`OS Ver: ${os.version()}`);
console.log(`System Type: ${os.type()}`)
console.log(`Processor Model: ${os.cpus()[0].model}`)