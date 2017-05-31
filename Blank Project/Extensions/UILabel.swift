//
//  UILabelExtension.swift
//  Blank Project
//
//  Created by framgia on 5/31/17.
//  Copyright © 2017 Vo Nguyen Chi Phuong. All rights reserved.
//

import UIKit

extension UILabel {

    func lineHeight(_ lineHeight: CGFloat) {
        if let attribute =  attributedText {
            let pragraphStyle = NSMutableParagraphStyle()
            pragraphStyle.lineHeightMultiple = lineHeight
            let attributeText = NSMutableAttributedString(attributedString: attribute)
            attributeText.addAttribute(NSParagraphStyleAttributeName, value: pragraphStyle, range: NSRange(location: 0, length: attributeText.length))
            attributedText = attributeText
        }

    }

    func spaceLineHeight(_ lineHeight: CGFloat) {
        if let attribute =  attributedText {
            let pragraphStyle = NSMutableParagraphStyle()
            pragraphStyle.lineSpacing = lineHeight
            pragraphStyle.alignment = self.textAlignment
            let attributeText = NSMutableAttributedString(attributedString: attribute)
            attributeText.addAttribute(NSParagraphStyleAttributeName, value: pragraphStyle, range: NSRange(location: 0, length: attributeText.length))
            self.attributedText = attributeText
        }
    }

    func setColorAttribute(color: UIColor) {
        if let attribute =  attributedText {
            let attributeText = NSMutableAttributedString(attributedString: attribute)
            attributeText.addAttribute(NSForegroundColorAttributeName, value: color, range: NSRange(location: 0, length: attributeText.length))
            self.attributedText = attributeText
        }
    }

    func setFontAttribute(font: UIFont) {
        if let attribute =  attributedText {
            let attributeText = NSMutableAttributedString(attributedString: attribute)
            attributeText.addAttribute(NSFontAttributeName, value: font, range: NSRange(location: 0, length: attributeText.length))
            self.attributedText = attributeText
        }
    }

    func setUnderLineNormal() {
        if let attribute =  attributedText {
            let attributeText = NSMutableAttributedString(attributedString: attribute)
            attributeText.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSRange(location: 0, length: attributeText.length))
            attributeText.addAttribute(NSUnderlineColorAttributeName, value: textColor, range: NSRange(location: 0, length: attributeText.length))
            self.attributedText = attributeText
        }
    }

    func sizeToFitCharacter(width: CGFloat) -> CGSize? {

        let context: NSStringDrawingContext = NSStringDrawingContext()
        if let size = self.text?.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                                              options: NSStringDrawingOptions.usesFontLeading,
                                              attributes: [NSFontAttributeName: self.font],
                                              context: context).size {

            return size
        } else {
            return nil
        }
    }

    func isTruncated() -> Bool {
        if let string = self.text {
            let size: CGSize = (string as NSString).boundingRect(
                with: CGSize(width: self.frame.size.width, height: CGFloat(FLT_MAX)),
                options: NSStringDrawingOptions.usesLineFragmentOrigin,
                attributes: [NSFontAttributeName: self.font],
                context: nil).size

            if size.height > self.bounds.size.height {
                return true
            }
        }
        return false
    }
}
