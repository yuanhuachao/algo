//
//  AppDelegate.swift
//  09_CircleQueue
//
//  Created by Yuan Hua Chao 袁华超 on 2018/10/10.
//  Copyright © 2018年 Yuan Hua Chao 袁华超. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        queueSize = 5
        var cirqueue = CircleQueue<Int>()
        cirqueue.enqueue(item: 2)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

