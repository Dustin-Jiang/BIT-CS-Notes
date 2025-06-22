const http = require("http");

const server = http.createServer((req, res) => {
  let statusCode = 418
  let statusDescription = "I am not a coffee pot. I am a teapot. "
  res.writeHead(statusCode, {
    "Content-Type": "text/plain; charset=utf-8"
  });
  res.end(`HTTP Status ${statusCode}: ${statusDescription}`)
});

const port = 8000
server.listen(port, () => {
  console.log(`Server listening at http://localhost:${port}`)
});