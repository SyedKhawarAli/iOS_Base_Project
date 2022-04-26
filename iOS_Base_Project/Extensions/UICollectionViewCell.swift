//
//  UICollectionViewCell.swift
//  Tespo Health
//
//  Created by BrainX Technologies on 22/05/2020.
//  Copyright © 2020 BrainX Technologies. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    static var nibName: String {
        return String(describing: self)
    }
}
