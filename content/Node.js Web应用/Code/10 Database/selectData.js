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

const sql = "SELECT * FROM websites WHERE ?";
const data = {
  username: "li"
};

connection.query(sql, data, (err, result, fields) => {
  if (err) throw err;
  console.log(result);
  console.log(result[0].username);
  console.log(result[0].password)
  console.log(fields);
});

connection.end((err) => {
  if (err) throw err;
});