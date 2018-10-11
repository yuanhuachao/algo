//
//  linkedList.swift
//  07_linkedList
//
//  Created by Yuan Hua Chao 袁华超 on 2018/10/11.
//  Copyright © 2018年 Yuan Hua Chao 袁华超. All rights reserved.
//

import Foundation

struct linkedList<T> {
    
    var head: Node<T>  //header of list (哨兵对象)
    
    
    func reverseLinkedList(head: Node<T>) ->linkedList<T> {
        
        var pre = head
        var cur = head.next
        var next = cur?.next
        
        
        while cur != nil {
            next = cur?.next
            if ObjectIdentifier(pre) == ObjectIdentifier(head) {
                cur?.next = nil
            } else {
                cur?.next = pre
            }
            pre = cur!
            cur = next
        }
        
        let newHead = head
        newHead.next = pre
        
        return linkedList(head: newHead)
    }
    
}

final class Node<T> {
    var data: T
    var next: Node<T>?
    
    init(data: T, next: Node<T>? = nil) {
        self.data = data
        self.next = next
    }
}







































