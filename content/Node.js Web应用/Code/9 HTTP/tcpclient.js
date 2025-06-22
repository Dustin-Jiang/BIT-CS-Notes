const net = require('net');

const client = net.createClient({
  host: '127.0.0.1',
  port: 8080
});

client.on('connect', () => {
  console.log('已连接到服务器');
  client.write('你好，我是客户端！');
});

client.on('data', (data) => {
  console.log('收到服务器回应：' + data.toString());
  client.end();
});

client.on('close', () => {
  console.log('连接已关闭');
});

client.connect(8080);  
