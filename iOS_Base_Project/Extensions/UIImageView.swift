//
//  UIImageView.swift
//  Education Platform
//
//  Created by Thanh-Tam Le on 1/11/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadImageFrom(url: URL?, placeholderIamgeName: String? = nil, errorImageName: String? = nil) {
        sd_setImage(with: url, placeholderImage: UIImage(named: placeholderIamgeName ?? "")) { _, error, _, _ in
            if error != nil {
                self.image = UIImage(named: errorImageName ?? "")
            }
        }
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    func roundImage() {
        ///height and width should be the same
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
    }
}
