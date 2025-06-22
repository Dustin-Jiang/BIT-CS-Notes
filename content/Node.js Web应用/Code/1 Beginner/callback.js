const foo = (val) => {
  console.log(`lol ${val}`)
}

const bar = (val, callback) => {
  callback(val)
}

bar("callback", foo)