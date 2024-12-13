const http = require('http');

const server = http.createServer((req, res) => {
  // 获取请求方法  
  const method = req.method;
  console.log('Method: ', method);

  // 获取请求地址  
  const url = req.url;
  console.log('Address: ', url);

  // 获取请求头  
  const headers = req.headers;
  console.log('Header: ', headers); 
});

server.listen(3000, () => {
  console.log('server listening...');
});  
