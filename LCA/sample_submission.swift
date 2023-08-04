import Foundation

class Queue<T> {
  private var items: [T] = []
  
  func enqueue(_ item: T) {
    items.append(item)
  }
  
  func dequeue() -> T? {
    return items.isEmpty ? nil : items.removeFirst()
  }
  
  func isEmpty() -> Bool {
    return items.isEmpty
  }
}

struct Edge {
  let from: Int
  let to: Int
  
  init(_ from: Int, _ to: Int) {
    self.from = from
    self.to = to
  }
}

class Graph {
  var adjacencyList: [Int: [Int]] = [:]
  
  func addEdge(_ edge: Edge) {
    if adjacencyList[edge.from] == nil {
      adjacencyList[edge.from] = []
    }
    adjacencyList[edge.from]?.append(edge.to)
  }
  
  func findLowestCommonAncestor(_ root: Int, _ node1: Int, _ node2: Int) -> Int? {
    var parentMap: [Int: Int] = [:]
    var visited: Set<Int> = [root]
    var queue = Queue<Int>()
    queue.enqueue(root)
    
    while !queue.isEmpty() {
      if let current = queue.dequeue() {
        if let neighbors = adjacencyList[current] {
          for neighbor in neighbors {
            if !visited.contains(neighbor) {
              visited.insert(neighbor)
              parentMap[neighbor] = current
              queue.enqueue(neighbor)
            }
          }
        }
      }
    }
    
    var pathToNode1: Set<Int> = [node1]
    var currentNode = node1
    while let parent = parentMap[currentNode] {
      pathToNode1.insert(parent)
      currentNode = parent
    }
    
    currentNode = node2
    while !pathToNode1.contains(currentNode) {
      currentNode = parentMap[currentNode]!
    }
    
    return currentNode
  }
}

func solution() {
  
  guard let N = Int(readLine()!) else { return }
  var graph = Graph()
  
  for _ in 0..<(N - 1) {
    let edgeInput = readLine()!.split(separator: " ").map { Int($0)! }
    let edge = Edge(edgeInput[0], edgeInput[1])
    graph.addEdge(edge)
  }
  
  guard let M = Int(readLine()!) else { return }
  var results: [Int] = []
  
  for _ in 0..<M {
    let query = readLine()!.split(separator: " ").map { Int($0)! }
    let lca = graph.findLowestCommonAncestor(1, query[0], query[1])
    results.append(lca!)
  }
  
  for result in results {
    print(result)
  }
}

