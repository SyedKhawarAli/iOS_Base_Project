//
//  TemplateButton.swift
//  zytrack_ios
//
//  Created by BrainX Technologies on 2/24/21.
//

import UIKit

class TemplateButton: UIButton {
    // MARK: - properties

    @IBInspectable var myBackgroundColor: UIColor = Color.tintColor

    @IBInspectable var titleText: String? {
        didSet {
            self.setTitle(titleText, for: .normal)
        }
    }

    // MARK: - Override Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = myBackgroundColor
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        titleLabel?.font = Font.brownBold(16)
    }
}
