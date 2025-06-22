const net = require('net');

const server = net.createServer((socket) => {
  console.log('客户端已连接：', socket.remoteAddress + ':' + socket.remotePort);

  socket.on('data', (data) => {
    console.log('收到数据：', data.toString());
    socket.send(data);
  });

  socket.on('close', () => {
    console.log('客户端已断开连接');
  });
});

server.listen(8080, () => {
  console.log('服务器已启动，等待客户端连接...');
});  
