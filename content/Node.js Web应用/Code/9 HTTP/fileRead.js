const http = require('http');
const fs = require('node:fs/promises')

const server = http.createServer((req, res) => {
  // 获取请求方法  
  const method = req.method;
  console.log('Method: ', method);

  // 获取请求地址  
  const url = new URL(req.url).pathname;
  if (req.method === "GET") {
    if (url === "/") {
      res.end("Index")
    }
    if (url === "/login") {
      res.end("Login")
    }
    if (url === "/pdf") {
      returnFile(req, res, "application/pdf")
    }
    if (url === "/jpg") {
      returnFile(req, res, "image/jpeg")
    }
  }
});

const returnFile = (req, res, mime) => {
  let file = (new URL(req.url)).searchParams["file"];
  res.setHeader("Content-Type", mime);
  fs.readFile(file).then((data) => res.end(data), (e) => { throw e; });
}

server.listen(3000, () => {
  console.log('server listening...');
});  
