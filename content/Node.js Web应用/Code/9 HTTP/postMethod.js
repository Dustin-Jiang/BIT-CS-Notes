const http = require('http');

const server = require('http').createServer((req, res) => {
  // 检查请求方法  
  if (req.method !== 'POST') {
    res.end('Invalid request method.');
    return;
  }

  // 获取 POST 参数  
  const rawBody = '';
  req.on('data', (chunk) => {
    rawBody += chunk.toString();
  });

  req.on('end', () => {
    // 解析 POST 参数  
    const bufferBody = Buffer.from(rawBody, 'utf-8');
    const params = JSON.parse(bufferBody);

    // 输出 POST 参数到控制台  
    console.log('POST Params: ', params);

    // 返回响应  
    res.end();
  });
});

server.listen(3000, () => {
  console.log('Server Listening...');
});  