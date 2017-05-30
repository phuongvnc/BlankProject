//
//  Color.swift
//  ATMCard
//
//  Created by framgia on 5/12/17.
//  Copyright © 2017 Vo Nguyen Chi Phuong. All rights reserved.
//

import UIKit

extension UIColor {
    class func colorRGB(red: Int, green: Int, blue: Int) -> UIColor {
        return colorRGBA(red: red, green: green, blue: blue, alpha: 1)
    }

    class func colorRGBA(red: Int, green: Int , blue: Int, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(red) / 255.0,
                       green: CGFloat(green) / 255.0,
                       blue: CGFloat(blue) / 255.0,
                       alpha: alpha)
    }

    class func colorHex(_ hex: String, alpha: CGFloat) -> UIColor {
        let hexInt = UIColor.intFromHex(hex)
        let color = UIColor(red: ((CGFloat) ((hexInt & 0xFF0000) >> 16))/255,
                            green: ((CGFloat) ((hexInt & 0xFF00) >> 8))/255,
                            blue: ((CGFloat) (hexInt & 0xFF))/255,
                            alpha: alpha)
        return color
    }

    private class func intFromHex(_ hex: String) -> UInt32 {
        var hexInt:UInt32 = 0
        let scanner = Scanner(string: hex)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }

    func isDistinct(compare color:UIColor) -> Bool {
        let mainComponents = self.cgColor.components!
        let compareComponents = color.cgColor.components!
        let threshold:CGFloat = 0.25

        if fabs(mainComponents[0] - compareComponents[0]) > threshold ||
            fabs(mainComponents[1] - compareComponents[1]) > threshold ||
            fabs(mainComponents[2] - compareComponents[2]) > threshold {
            if fabs(mainComponents[0] - mainComponents[1]) < 0.03 && fabs(compareComponents[0] - compareComponents[2]) < 0.03 {
                if fabs(compareComponents[0] - compareComponents[1]) < 0.03 && fabs(compareComponents[0] - compareComponents[2]) < 0.03 {
                    return false
                }
            }
            return true
        }
        return false
    }


    static let mainColor = UIColor.colorRGB(red: 176, green: 0, blue: 109)
    static let subColor  = UIColor.colorRGB(red: 122, green: 1, blue: 78)
    static let navigationColor = UIColor.colorRGB(red: 50, green: 83, blue: 64)
    static let backgroundTextField = UIColor.colorRGB(red: 234, green: 239, blue: 242)
    static let borderTextField = UIColor.colorRGB(red: 218, green: 225, blue: 230)
}
