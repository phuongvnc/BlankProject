//
//  Optional.swift
//  Blank Project
//
//  Created by framgia on 6/6/17.
//  Copyright © 2017 Vo Nguyen Chi Phuong. All rights reserved.
//

import Foundation

extension Optional {
    
    var isEmpty: Bool {
        switch self {
        case .none:
            return true
        case .some(_):
            return false
        }
    }
}
