//
//  UIStoryboardExtension.swift
//  Blank Project
//
//  Created by framgia on 5/29/17.
//  Copyright © 2017 Vo Nguyen Chi Phuong. All rights reserved.
//

import UIKit

enum Storyboard : String {
    case main = "Main"
}

extension UIStoryboard {

    static func loadFromMain(_ identifier: String) -> UIViewController {
        return load(from: .main, identifier: identifier)
    }

    static func load(from storyboard: Storyboard, identifier: String) -> UIViewController {
        let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return uiStoryboard.instantiateViewController(withIdentifier: identifier)
    }

}

// MARK: App View Controllers

extension UIStoryboardSegue {
    func destinationViewController<T: UIViewController>(aClass: T.Type) -> T {
        guard let controller = destination as? T else {
            fatalError("Destination view controller isn't \(T.className)")
        }
        return controller
    }
}
