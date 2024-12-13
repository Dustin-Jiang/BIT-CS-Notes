const http = require('http');

const server = http.createServer((req, res) => {
  // 设置响应头  
  res.writeHead(200, { 'Content-Type': 'text/plain' });

  // 写入响应体  
  res.write('Hello, World!');

  // 结束响应  
  res.end();
});

server.listen(3000, () => {
  console.log('server listening...');
});  
