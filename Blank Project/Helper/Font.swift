//
//  Font.swift
//  Blank Project
//
//  Created by framgia on 6/5/17.
//  Copyright © 2017 Vo Nguyen Chi Phuong. All rights reserved.
//
import Foundation
import UIKit

struct Font {
    static var HiraKakuProN = HiraKakuProNFont()
    static var HiraKakuPro = HiraKakuProFont()
    static var HiraginoSans = HiraginoSansFont()

    static func preloads(completion: (() -> Void)?) {
        //        dp_background { () -> Void in
        //            HiraKakuProN.W6(12)
        //            completion?()
        //        }
    }


}

class HiraKakuProFont: CustomFont {
    override var name: FontName! {
        return .HiraKakuPro
    }

    func W3(fontSize: CGFloat) -> UIFont! {
        return CCFont(name: name, .W3, fontSize)
    }

    func W6(fontSize: CGFloat) -> UIFont! {
        return CCFont(name: name, .W6, fontSize)
    }
}

class HiraKakuProNFont: CustomFont {
    override var name: FontName! {
        return .HiraKakuProN
    }

    func W3(fontSize: CGFloat) -> UIFont! {
        return CCFont(name: name, .W3, fontSize)
    }

    func W6(fontSize: CGFloat) -> UIFont! {
        return CCFont(name: name, .W6, fontSize)
    }
}

class HiraginoSansFont: CustomFont {
    override var name: FontName! {
        return .HiraginoSans
    }

    func W3(fontSize: CGFloat) -> UIFont! {
        return CCFont(name: name, .W3, fontSize)
    }

    func W6(fontSize: CGFloat) -> UIFont! {
        return CCFont(name: name, .W6, fontSize)
    }
}

// MARK: - Custom Font Table
/*
 Example: label.font = Font(.Lato, .Bold, 12)
 */
enum FontName: String {
    case HiraKakuPro = "HiraKakuPro"
    case HiraKakuProN = "HiraKakuProN"
    case HiraginoSans = "HiraginoSans"

    var familyName: String {
        switch self {
        case .HiraKakuPro:
            return "Hiragino Kaku Gothic Pro"
        case .HiraKakuProN:
            return "Hiragino Kaku Gothic ProN"
        case .HiraginoSans:
            return "Hiragino Sans"
        }
    }
}

enum FontType: String {
    case Black = "-Black"
    case BlackItalic = "-BlackItalic"
    case Bold = "-Bold"
    case BoldItalic = "-BoldItalic"
    case ExtraBold = "-ExtraBold"
    case ExtraBoldItalic = "-ExtraBoldItalic"
    case Hairline = "-Hairline"
    case HairlineItalic = "-HairlineItalic"
    case Heavy = "-Heavy"
    case HeavyItalic = "-HeavyItalic"
    case Italic = "-Italic"
    case Light = "-Light"
    case LightItalic = "-LightItalic"
    case Medium = "-Medium"
    case MediumItalic = "-MediumItalic"
    case Regular = "-Regular"
    case Semibold = "-Semibold"
    case SemiboldItalic = "-SemiboldItalic"
    case Thin = "-Thin"
    case ThinItalic = "-ThinItalic"
    case Ultra = "-Ultra"
    case W3 = "-W3"
    case W6 = "-W6"
}

enum PSDFontScale: CGFloat {
    case Phone45 = 1.0
    case Phone6 = 1.117
    case Phone6p = 1.3
}




let fontScale: PSDFontScale = (Helper.isIPhone4Or4s || Helper.isIPhone5Or5s ? .Phone45 : Helper.isIPhone6Or7 ? .Phone6 : .Phone6p)

func CCFont(name: FontName, _ type: FontType, _ size: CGFloat) -> UIFont! {
    let fontName = name.rawValue + type.rawValue
    let fontSize = size * fontScale.rawValue
    let font = UIFont(name: fontName, size: fontSize)
    if let font = font {
        return font
    } else {
        // Console.log("\(fontName) is invalid font.", level: .Error)
        return UIFont.systemFont(ofSize: fontSize)
    }
}
class CustomFont {
    var name: FontName! { return nil }
    init() { }
    var description: String {
        if let name = name {
            let fonts = UIFont.fontNames(forFamilyName: name.familyName)
            return "\(fonts)"
        }
        return ""
    }
}
