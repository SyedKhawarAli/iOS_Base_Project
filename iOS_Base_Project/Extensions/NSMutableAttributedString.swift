//
//  NSMutableAttributedString.swift
//  zytrack_ios
//
//  Created by BrainX 3096 on 30/09/2021.
//

import UIKit

extension NSMutableAttributedString {
    var fontSize: CGFloat { return 16 }
    var boldFont: UIFont { return Font.brownBold(fontSize) }
    var normalFont: UIFont { return Font.brownRegular(fontSize) }

    func bold(_ value: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: boldFont,
        ]

        append(NSAttributedString(string: value, attributes: attributes))
        return self
    }

    func normal(_ value: String, font: UIFont = Font.brownRegular(16)) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
        ]

        append(NSAttributedString(string: value, attributes: attributes))
        return self
    }

    func customWith(_ value: String, font: UIFont, color: UIColor) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
        ]

        append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
}
