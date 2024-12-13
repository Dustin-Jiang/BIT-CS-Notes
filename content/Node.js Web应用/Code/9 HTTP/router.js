const http = require('http');

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
  }
});

server.listen(3000, () => {
  console.log('server listening...');
});  
