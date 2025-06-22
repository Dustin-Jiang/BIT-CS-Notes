const dns = require("dns")

dns.lookup("example.org", (err, addr, family) => {
  if (err) throw err;

  console.log(addr)
  console.log(family)
})