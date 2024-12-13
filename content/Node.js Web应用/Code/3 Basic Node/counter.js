class Counter {
  constructor(val = 0) {
    this.__val = val;
  }
  get value() {
    this.__val ++
    return this.__val
  }
  set value (val) {
    this.__val = val
  }
}

module.exports = {
  Counter
}