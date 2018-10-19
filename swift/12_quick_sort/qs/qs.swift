//
//  qs.swift
//  qs
//
//  Created by Yuan Hua Chao 袁华超 on 2018/10/17.
//  Copyright © 2018 Yuan Hua Chao 袁华超. All rights reserved.
//

import Foundation

func qs<T: Comparable>(array: inout [T], begin: inout Int, end: inout Int) {
    
    var base = begin
    var right = end
    
    guard begin < end else {
        return
    }
    
    while begin < end {
        while (begin < end && array[end] >= array[base]) {
            end -= 1
        }
//        array[begin] = array[end]
        
        while (begin < end && array[begin] <= array[base]) {
            begin += 1
        }
//        array[end] = array[begin]
        
        let temp = array[begin]
        array[begin] = array[end]
        array[end] = temp
       
    }
    
    let temp = array[begin]
    array[begin] = array[base]
    array[base] = temp
    
//    array[begin] = array[base]
    
    var be = begin - 1
    qs(array: &array, begin: &base, end: &be)
    var be2 = begin + 1
    qs(array: &array, begin: &be2 , end: &right)
    
}













































