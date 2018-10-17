//
//  AppDelegate.swift
//  ss
//
//  Created by Yuan Hua Chao 袁华超 on 2018/10/11.
//  Copyright © 2018年 Yuan Hua Chao 袁华超. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let head = Node(data: 0)
        let head1 = Node(data: 1)
        let head2 = Node(data: 4)
        let head3 = Node(data: 5)
        let head4 = Node(data: 8)
        let head5 = Node(data: 14)
        head.next = head1
        head1.next = head2
        head2.next = head3
        head3.next = head4
        head4.next = head5
        
        
        let heade = Node(data: 0)
        let heade1 = Node(data: 2)
        let heade2 = Node(data: 2)
        let heade3 = Node(data: 9)
        let heade4 = Node(data: 11)
//        let heade5 = Node(data: 14)
        heade.next = head1
        heade1.next = head
        heade2.next = heade3
        heade3.next = heade4
        heade4.next = nil
        
//        let list1 = linkedList(head: head)
//        let list2 = linkedList(head: heade)
        
//        var node = linkedList<Int>.combineOrderedList(head1: head, head2: heade)
//        var node = linkedList<Int>.combineOrderedList2(head1: head, head2: heade)
//        let list = list1.reverseLinkedList(head: head)
//        var node = list.head
//        while node?.next != nil {
//            print(node?.next?.data ?? -100)
//            node = node?.next!
//        }
        
        let list = linkedList(head: heade)
        var isCir:Bool = list.detectionLoop(head: heade)
        
        var nd = list.deleteNodeBackwards(head: head, backwardsIndex: 7)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

