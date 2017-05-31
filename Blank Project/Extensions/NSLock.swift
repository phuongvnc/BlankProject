//
//  NSLock.swift
//  Blank Project
//
//  Created by framgia on 5/31/17.
//  Copyright © 2017 Vo Nguyen Chi Phuong. All rights reserved.
//

import Foundation

extension NSLock {
    public func sync( block: () -> Void) {
        let locked = self.try()
        block()
        if locked {
            unlock()
        }
    }
}

