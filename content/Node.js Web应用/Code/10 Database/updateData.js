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

const sql = "UPDATE websites SET ? WHERE username = ?";
const data = {
  username: "li",
  password: "123456"
};

connection.query(sql, [data, data.username], (err, result, fields) => {
  if (err) throw err;
  console.log(result);
  console.log(fields);
});

connection.end((err) => {
  if (err) throw err;
});