//
//  UIColor.swift
//  Signature
//
//  Created by Thanh-Tam Le on 8/31/16.
//  Copyright © 2016 Thanh-Tam Le. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(_ value: Int) {
        let r = CGFloat(value >> 16 & 0xFF) / 255.0
        let g = CGFloat(value >> 8 & 0xFF) / 255.0
        let b = CGFloat(value & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    var coreImageColor: CoreImage.CIColor {
        return CoreImage.CIColor(color: self)
    }
    
    static func getRandomColor() -> UIColor{
        let randomRed = CGFloat(drand48())
        let randomGreen = CGFloat(drand48())
        let randomBlue = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
