//
//  lu.swift
//  lu
//
//  Created by Yuan Hua Chao 袁华超 on 2018/10/23.
//  Copyright © 2018 Yuan Hua Chao 袁华超. All rights reserved.
//

import Foundation

var lock: pthread_mutex_t = pthread_mutex_t()

private struct Map {
    var dic: Dictionary<String, LinkedMapNode>? = Dictionary()
    weak var head: LinkedMapNode?
    weak var tail: LinkedMapNode?
    var totalCount: UInt = 0
    var totalCost: UInt = 0
    
    fileprivate mutating func insertNodeToHead(node: LinkedMapNode?) {
        
        guard let _ = head else {
            head = node
            tail = node
            return
        }
        
        node?.nextNode = head
        head?.preNode = node
    }
    
    fileprivate func bringNodeToHead(node: LinkedMapNode) {
        if ObjectIdentifier(node) == ObjectIdentifier(head!) {
            return
        } else if ObjectIdentifier(node) == ObjectIdentifier(tail!) {
            tail?.preNode?.nextNode = nil
            node.nextNode = head
        } else {
            node.preNode?.nextNode = node.nextNode
            node.nextNode?.preNode = node.preNode
        }
        
        node.preNode = nil
        head?.preNode = node
    }
    
    fileprivate mutating func removeNodeAtTail() ->LinkedMapNode? {
        guard let _ = tail else {
            return nil
        }
        
        totalCost -= tail!.cost
        tail?.preNode?.nextNode = nil
        dic?.removeValue(forKey: tail!.key)
        
        return tail
    }
    
    fileprivate mutating func removeAll() {
        dic?.removeAll()
        totalCost = 0
        head = nil
        tail = nil
    }
    
    fileprivate mutating func removeNode(key: String) {
        let node = dic?[key]
        
        guard let _ = node else {
            return
        }
        
        if (ObjectIdentifier(node!) == ObjectIdentifier(head!)) {
            head?.nextNode?.preNode = nil
            head = head?.nextNode
        } else if (ObjectIdentifier(node!) == ObjectIdentifier(tail!)) {
            tail?.preNode?.nextNode = nil
            tail = tail?.preNode
        } else {
            node?.preNode?.nextNode = node?.nextNode
            node?.nextNode?.preNode = node?.preNode
        }
        
        dic?.removeValue(forKey: key)
        totalCost -= node!.cost
    }
    
}

final class LinkedMapNode {
    var value: Any
    var key: String
    
    var preNode: LinkedMapNode?
    var nextNode: LinkedMapNode?
    
    var cost: UInt = 0
    var time: TimeInterval?
    
    init (key:String, value: Any) {
        self.value = value
        self.key = key
    }
}


class LRUCache {
    
    fileprivate var map: Map?
    var limitedCost: UInt = 0
    
    func setObject(object: Any?, key: String, cost: UInt = 0) {
        
        guard let _ = object else {
            self.removeObject(key: key)
            return
        }
        
        pthread_mutex_lock(&lock)
        
        let node  = map?.dic?[key]
        let time = Date.timeIntervalBetween1970AndReferenceDate
        if (node != nil) {
            map?.totalCost -= node?.cost ?? 0
            map?.totalCost += cost
            node?.value = object!
            node?.cost = cost
            node?.time = time
            map?.bringNodeToHead(node: node!)
        } else {
            map?.totalCost += cost
            let node = LinkedMapNode(key: key, value: object!)
            node.cost = cost
            node.time = time
            map?.insertNodeToHead(node: node)
        }
        
        if map?.totalCost ?? 0 > limitedCost {
            self.cleanMemory(costToClean: limitedCost - (map?.totalCost ?? 0))
        }
        
        pthread_mutex_unlock(&lock)
    }
    
    func getObject(key: String) ->Any? {
        
        pthread_mutex_lock(&lock)
        
        let node = map?.dic?[key]
        if node != nil {
            map?.bringNodeToHead(node: node!)
        }
        
        pthread_mutex_unlock(&lock)
        
        return node?.value
        
        
    }
    
    fileprivate func cleanMemory(costToClean: UInt) ->Bool {
        var cleanedMemory: UInt = 0

        if map?.tail == nil || map?.head == nil {
            return false
        }

        while (cleanedMemory < costToClean && map?.tail != nil && map?.head != nil) {
            let node = map?.removeNodeAtTail()
            cleanedMemory += (node?.cost ?? 0)
        }
        
        if (cleanedMemory >= costToClean) {
            return true
        } else {
            return false
        }
    }
    
    
    func removeObject(key: String) {
        
        pthread_mutex_lock(&lock)
        
        let node = map?.dic?[key]
        if node != nil {
            map?.removeNode(key: key)
        }
        
        pthread_mutex_unlock(&lock)
    }
    
}














































