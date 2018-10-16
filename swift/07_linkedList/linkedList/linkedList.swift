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
    
    //reverse linkedList
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
    
    //detection loop in linkedList
    func detectionLoop(head: Node<T>) ->Bool {
        
        
        
        
        return false
    }
    
    //combine list with circulation
    static func combineOrderedList(head1: Node<Int>, head2: Node<Int>) ->Node<Int> {
        
        var node1 = head1.next
        var node2 = head2.next
        let head = Node<Int>(data: -1)
        
        var nodeNew: Node<Int>?
        
        if ((node1?.data)! > (node2?.data)!) {
            nodeNew = node2
            node2 = node2?.next
        } else {
            nodeNew = node1
            node1 = node1?.next
        }
        
        head.next = nodeNew
        
        while (node1 != nil && node2 != nil) {
            
            if ((node1?.data)! > (node2?.data)!) {
                
                nodeNew?.next = node2
                node2 = node2?.next
            } else {
                
                nodeNew?.next = node1
                node1 = node1?.next
            }
            
            nodeNew = nodeNew?.next
        }
        
        if (node1 == nil) {
            nodeNew?.next = node2
        } else if (node2 == nil) {
            nodeNew?.next = node1
        }
        
        return head
    }
    
    //combine list with recursion
    static func combineOrderedList2(head1: Node<Int>?, head2: Node<Int>?) ->Node<Int>? {
        
        var headNew: Node<Int>?
        
        if head1 == nil {
            return head2
        }
        if head2 == nil {
            return head1
        }
        
        if ((head1?.data)! <= (head2?.data)!) {
            headNew = head1
            headNew?.next = combineOrderedList2(head1: head1?.next, head2: head2)
        } else {
            headNew = head2
            headNew?.next = combineOrderedList2(head1: head1, head2: head2?.next)
        }
        
        return headNew
    }
    
}

final class Node<T> {
    
    var data: T
    var next: Node<T>?
    
    init(data: T, next: Node<T>? = nil) {
        self.data = data
        self.next = next
    }
    
    func copy(with zone: NSZone? = nil) -> Node<T> {
        let node = Node(data: self.data, next: self.next)
        return node
    }
}







































