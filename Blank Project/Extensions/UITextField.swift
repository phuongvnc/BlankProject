//
//  UITextFieldExtension.swift
//  Blank Project
//
//  Created by framgia on 5/31/17.
//  Copyright © 2017 Vo Nguyen Chi Phuong. All rights reserved.
//

import UIKit

extension UITextField {


    func isLimitCharacter(characterLimit: Int, range: NSRange) -> Bool {
        guard let text = self.text else {
            return false
        }
        return !(text.characters.count > characterLimit - 1 &&
            text.characters.count > range.length)
    }
}
