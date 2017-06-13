//
//  ExpandTextField.swift
//  Coffee Bussiness
//
//  Created by framgia on 6/12/17.
//  Copyright © 2017 Coffee. All rights reserved.
//

import UIKit

class ExpandTextField: UITextField {
    var label: UILabel!

    override var placeholder: String? {
        didSet {
            label.text = placeholder
            changeColorPlaceholder()
        }
    }

    override var font: UIFont? {
        didSet {
            label.font = font ?? UIFont.systemFont(ofSize: 14)
        }
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        label = UILabel(frame: bounds)
        label.textColor = UIColor.lightGray
        label.text = placeholder
        label.font = font ?? UIFont.systemFont(ofSize: 14)
        changeColorPlaceholder()
        self.insertSubview(label, at: 0)
        addTarget(self, action: #selector(editingChangedValue(textField:)), for: .editingChanged)
    }

    func changeColorPlaceholder() {
        let attributed = NSMutableAttributedString(string: placeholder ?? "", attributes: [NSForegroundColorAttributeName : UIColor.clear])
        attributedPlaceholder = attributed
    }

    func editingChangedValue(textField: UITextField) {
        let value = textField.text ?? ""
        showAnimation(isExpand: !value.isEmpty)
    }

    func showAnimation(isExpand: Bool) {
        var transform: CGAffineTransform
        if isExpand {
            transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        } else {
            transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        UIView.animate(withDuration: 0.25) {
            self.label.transform = transform
            self.transform = CGAffineTransform.identity
            self.label.frame.origin = isExpand ? CGPoint(x: 0,  y: -10) : CGPoint.zero
            self.layer.transform =  isExpand ? CATransform3DMakeTranslation(0, 8, 0) : CATransform3DMakeTranslation(0, 0, 0)
        }
    }
}
