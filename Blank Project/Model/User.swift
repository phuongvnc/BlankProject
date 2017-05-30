//
//  User.swift
//  Blank Project
//
//  Created by framgia on 5/22/17.
//  Copyright © 2017 Vo Nguyen Chi Phuong. All rights reserved.
//

import Foundation

private enum UserKey: String {
    case username = "username"
}

class User: NSObject, NSSecureCoding {

    var username: String = ""
    static var supportsSecureCoding: Bool = true

    init(username: String, pincode: String) {
        self.username = username

    }

    required init?(coder aDecoder: NSCoder) {
        if let username = aDecoder.decodeObject(forKey: UserKey.username.rawValue) as? String {
            self.username = username
        }
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(username, forKey: UserKey.username.rawValue)
    }
}
