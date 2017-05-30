//
//  NSObjectExtension.swift
//  Blank Project
//
//  Created by framgia on 5/29/17.
//  Copyright © 2017 Vo Nguyen Chi Phuong. All rights reserved.
//

import Foundation


extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
