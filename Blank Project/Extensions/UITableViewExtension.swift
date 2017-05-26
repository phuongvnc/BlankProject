//
//  UITableViewExtension.swift
//  ATMCard
//
//  Created by framgia on 5/15/17.
//  Copyright © 2017 Vo Nguyen Chi Phuong. All rights reserved.
//

import UIKit

extension UITableView {

    func removeHeaderTableView() {
        tableHeaderView = UIView()
    }

    func setAndLayoutTableHeaderView(header: UIView?) {
        guard let header = header else {
            return
        }
        header.setNeedsLayout()
        header.layoutIfNeeded()
        let height = header.systemLayoutSizeFitting(CGSize(width: bounds.width, height: 0), withHorizontalFittingPriority: UILayoutPriorityRequired, verticalFittingPriority: UILayoutPriorityFittingSizeLevel).height
        var frame = header.frame
        frame.size.height = height
        header.frame = frame
        tableHeaderView = header
    }

    func registerCell<T:UITableViewCell>(aClass: T.Type) {
        let className = String(describing: aClass)
        let nibFile = UINib(nibName: className , bundle: nil)
        register(nibFile, forCellReuseIdentifier: className)
    }

    func dequeueCell<T: UITableViewCell> (aClass: T.Type, indexPath: IndexPath) -> T? {
        let className = String(describing: aClass)
        let cell = dequeueReusableCell(withIdentifier: className, for: indexPath)
        return cell as? T
    }

    func dequeueCell<T: UITableViewCell> (aClass: T.Type) -> T? {
        let className = String(describing: aClass)
        let cell = dequeueReusableCell(withIdentifier: className)
        return cell as? T
    }
}
