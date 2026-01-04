![[Pasted image 20250106142025.png]]

```cpp
// Dijkstra算法的实现函数
// 参数：图graph，节点数n，起始节点source
vector<int> dijkstra(const vector<vector<Edge>>& graph, int n, int source) {
    // 距离数组，用于存储源点到每个节点的最小距离，初始化为无穷大
    vector<int> distances(n, numeric_limits<int>::max());
    // 标记数组，用于判断节点是否已经被优化
    vector<bool> visited(n, false);

    // 小根堆优先队列，用于快速获取未访问节点中距离最小的节点
    priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> minHeap;
    
    // 初始化源点的距离为0，并将其加入优先队列
    distances[source] = 0;
    minHeap.push({0, source});

    // 主循环，当优先队列不为空时执行
    while (!minHeap.empty()) {
        // 从优先队列中取出距离最小的节点
        int current_distance = minHeap.top().first;
        int current_node = minHeap.top().second;
        minHeap.pop();

        // 如果当前节点已经被访问过，则跳过
        if (visited[current_node]) continue;

        // 标记当前节点为已访问
        visited[current_node] = true;

        // 遍历当前节点的所有邻接边
        for (const Edge& edge : graph[current_node]) {
            int neighbor = edge.to;
            int weight = edge.weight;

            // 计算通过当前节点到达邻居节点的距离
            int new_distance = current_distance + weight;

            // 如果计算出的新距离小于已知的距离，则进行距离更新
            if (new_distance < distances[neighbor]) {
                distances[neighbor] = new_distance;
                // 将邻居节点和更新后的距离加入优先队列
                minHeap.push({new_distance, neighbor});
            }
        }
    }

    return distances; // 返回源点到各个节点的最短距离
}
```
