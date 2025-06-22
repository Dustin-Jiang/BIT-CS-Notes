const db = require("./db")

const sql = 'INSERT INTO websites set ?'
const data = {
  username: "li1",
  password: "123456"
}

db.base(sql, data, (results, fields) => {
  console.log(results)
  console.log(fields)
})