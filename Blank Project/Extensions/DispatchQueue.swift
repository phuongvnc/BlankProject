//
//  DispatchQueueExtension.swift
//  Blank Project
//
//  Created by framgia on 5/22/17.
//  Copyright © 2017 Vo Nguyen Chi Phuong. All rights reserved.
//

import UIKit

extension DispatchQueue {

    class func after(time: TimeInterval,_ block: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) { 
            block()
        }
    }
}

class GCDGroup {
    var queue: DispatchQueue!
    var group: DispatchGroup!
    var allCompletion: (() -> ())?

    init(thread: DispatchQueue) {
        queue = DispatchQueue(label: "GROUP")
        queue.setTarget(queue: thread)
        group = DispatchGroup()

        group.notify(queue: .main) { 
            self.allCompletion?()
        }
    }

    func addWork(_ work: @escaping () -> ()) {
        group.enter()
        queue.async(group: group, execute: {
            work()
            self.group.leave()
        })
    }
}
