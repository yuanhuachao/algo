//
//  sList.swift
//  skipList
//
//  Created by Yuan Hua Chao 袁华超 on 2018/10/31.
//  Copyright © 2018 Yuan Hua Chao 袁华超. All rights reserved.
//

import Foundation

public struct Stack<T> {
    fileprivate var array: [T] = []
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
    public func peek() -> T? {
        return array.last
    }
}

extension Stack: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        var curr = self
        return AnyIterator { curr.pop() }
    }
}

private func cointFlip() ->Bool {
    return arc4random_uniform(2) == 1
}

public class DataNode<Key: Comparable, Payload> {
     public typealias Node = DataNode<Key, Payload>
    
    var data: Payload?
    fileprivate var key: Key?
    var next: Node?
    var down: Node?
    
    public init(key: Key, data: Payload) {
        self.key  = key
        self.data = data
    }
    
    public init(asHead head: Bool) {}

}

open class SkipList<Key: Comparable, Payload> {
    public typealias Node = DataNode<Key, Payload>
    
    fileprivate(set) var head: Node?
    
    public init() {}
    
    // MARK: findNode  search
    // bootstrapBaseLayer   insertItem  insert
    // remove
    // get
}

extension SkipList{
    
    public func findNode(key: Key) ->Node? {
        guard let head = head else {
            return nil
        }
        
        var currentNode: Node? = head
        var isFound: Bool = false
        
        while !isFound {
            
            if let node = currentNode {
                switch node.next {
                case .none:
                    currentNode = node.down
                case .some(let value) where value.key != nil:
                    
                    if value.key == key {
                        isFound = true
                        break
                    } else {
                        if value.key! > key {
                            currentNode = node.down
                        } else {
                            currentNode = node.next
                        }
                    }
                    break
                    
                default:
                    continue
                }
            }else {
                break
            }
        }
        
        if (!isFound) {
            return nil
        } else {
            return currentNode
        }
    }
    
    public func search(key: Key) ->Node? {
        if let node = self.findNode(key: key) {
            return node.next
        } else {
            return nil
        }
    }
}


extension SkipList {
    
    public func bootstripBaseLayer(key: Key, data: Payload) {
        head = Node(asHead: true)
        let node = Node(key: key, data: data)
        head?.next = node
        var currentTopNode = node
        
        while cointFlip() {
            let newHead = Node(asHead: true)
            let newNode = Node(key: key, data: data)
            newNode.down = currentTopNode
            newHead.next = newNode
            newHead.down = head
            head = newHead
            currentTopNode = newNode
        }
    }
    
    
    public func insertItem(key: Key, data: Payload) {
        let node = findNode(key: key)
        
        if node != nil {
            var currentNode = node
            while (currentNode != nil && currentNode?.key == key) {
                currentNode?.data = data
                currentNode = currentNode?.next
            }
        } else {
            let node = head?.next
            var currentNode = node
            var stack = Stack<Node>()
            while (currentNode != nil) {
                if let nextData = currentNode?.next {
                    if (nextData.key)! < key {
                        currentNode = nextData
                    } else {
                        stack.push(currentNode!)
                        currentNode = currentNode?.down
                    }
                } else {
                    stack.push(currentNode!)
                    currentNode = currentNode?.down
                }
            }
            
            let nodeAtBaseLayer = stack.pop()
            let newNode = Node(key: key, data: data)
            newNode.next = nodeAtBaseLayer?.next
            nodeAtBaseLayer?.next = newNode
            
            var currnetTopNode = newNode
            
            while cointFlip() {
                if stack.isEmpty {
                    let newHead = Node(asHead: true)
                    let node = Node(key: key, data: data)
                    newHead.next = node
                    node.down = currnetTopNode
                    newHead.down = head
                    head = newHead
                    currnetTopNode = node
                } else {
                    let node = stack.pop()
                    let newNode = Node(key: key, data: data)
                    newNode.next = node?.next
                    node?.next = newNode
                    newNode.down = currnetTopNode
                    currnetTopNode = newNode
                }
            }
        }
    }
    
    
    public func insert(key: Key, data: Payload) {
        
        if head != nil {
            
            
            
            insertItem(key: key, data: data)
        } else {
            bootstripBaseLayer(key: key, data: data)
        }
        
    }
    
}





















































































