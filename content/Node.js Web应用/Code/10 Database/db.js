const mysql = require("mysql");

const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "123456",
  port: "3306",
  database: "test"
});

connection.connect((err) => {
  if (err) throw err;
});

const base = (sql, data, callback) => {
  connection.query(sql, data, callback)
}

module.exports = {
  base
}