//
//  CircleQueue.swift
//  09_CircleQueue
//
//  Created by Yuan Hua Chao 袁华超 on 2018/10/10.
//  Copyright © 2018年 Yuan Hua Chao 袁华超. All rights reserved.
//

import Foundation

var queueSize: Int = 0  // the max count of items in circle queue

struct CircleQueue<T> {
    
    var canDilatation: Bool = false
    fileprivate var front: Int = 0   // the head pointer of circle queueß
    fileprivate var rear: Int = 0   // the tail pointer of circle queue
    fileprivate var count: Int = 0  // the count of items currently
    fileprivate var itemArray: [T] = Array(repeating: T.self, count: queueSize) as! [T]  // the array to store items
    
    fileprivate func isQueueFull() ->Bool {
        return count == queueSize
    }
    
    fileprivate func isQueueEmpty() ->Bool {
        return count == 0
    }
    
    func itemCountOfQueue() ->Int {
        return count
    }
    
    fileprivate func moveItems(originItemArray: [T], destinationItemArray: inout [T], front: inout Int, rear: inout Int) {
        for i in 0 ..< originItemArray.count {
            destinationItemArray[i] = originItemArray[front]
            front = (front + 1) % queueSize
        }
        front = 0
        rear = originItemArray.count
    }
    
    mutating func enqueue(item: T) {
        
        if isQueueFull() {
            if !canDilatation {
                print("queue is full")
                return
            } else {
                let arr = itemArray
                queueSize *= 2
                itemArray = Array(repeating: T.self, count: queueSize) as! [T]
                
                moveItems(originItemArray: arr, destinationItemArray: &itemArray, front: &front, rear: &rear)
            }
        }
        
        count += 1
        itemArray[rear] = item
        rear = (rear + 1) % queueSize
    }
    
    mutating func dequeue() ->T? {
        guard isQueueEmpty() else {
            print("queue is empty")
            return nil
        }
        
        count -= 1
        front = (front + 1) % queueSize
        
        return itemArray[front]
    }
}
