const mysql = require("mysql")

const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "123456",
  port: "3306",
  database: "test"
})

connection.connect((err) => {
  if (err) throw err
})

const sql = "INSERT INTO websites (username, password) VALUES (?, ?)"
const data = ['test', '123456']

connection.query(sql, data, (err, result, fields) => {
  if (err) throw err
  console.log(result.insertId)
  console.log(result)
  console.log(fields)
})

connection.end((err) => {
  if (err) throw err
})