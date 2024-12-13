const http = require('http');

const server = http.createServer((req, res) => {
  // 获取 URL 参数  
  const queryString = req.url.split('?')[1];
  const params = parseQueryString(queryString);

  // 输出 URL
  console.log('URL 参数：', params);

  res.end();
});

// 解析查询字符串  
function parseQueryString(queryString) {
  const params = {};
  const keyValuePairs = queryString.split('&');

  keyValuePairs.forEach(pair => {
    const [key, value] = pair.split('=');
    params[decodeURIComponent(key)] = decodeURIComponent(value);
  });

  return params;
}

server.listen(3000, () => {
  console.log('Server Listening...');
});  
