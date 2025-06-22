const mysql = require("mysql");

const pool = mysql.createPool({
  host: "localhost",
  user: "root",
  password: "123456",
  port: "3306",
  database: "test",
  connectionLimit: 10
});

pool.connect((err) => {
  if (err) throw err;
});

const base = (sql, data, callback) => {
  pool.getConnection((err, connection) => {
    if (err) throw err;
    connection.query(sql, data, callback)
  })
}

module.exports = { base }