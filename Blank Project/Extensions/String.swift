//
//  StringExtension.swift
//  Blank Project
//
//  Created by framgia on 5/29/17.
//  Copyright © 2017 Vo Nguyen Chi Phuong. All rights reserved.
//

import Foundation

extension String {

    var length: Int {
        return self.characters.count
    }

    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }

    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }

    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound - r.lowerBound)
        return self[Range(start ..< end)]
    }

    func utf8String() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlHostAllowed)
    }

}
