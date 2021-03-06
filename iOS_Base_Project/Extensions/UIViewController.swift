//
//  UIViewController+Extentions.swift
//  iCareBenefit
//
//  Created by Nam Truong on 5/13/15.
//  Copyright (c) 2015 Nam Truong. All rights reserved.
//

import UIKit


extension UIViewController {
    func isRootViewController() -> Bool {
        if let array = self.navigationController?.viewControllers {
            if array.count>0 {
                return array[0] == self
            }
        }
        return false
    }
    
    static var storyboardId: String {
        return String(describing: self)
    }
    
    static func instantiate<ViewController: UIViewController>(_ viewControllerType: ViewController.Type, fromStoryboard storyboardName: UIStoryboard.Name) -> ViewController {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: viewControllerType.storyboardId) as! ViewController
    }
}

extension UINavigationController {
    func popViewControllerWithHandler(completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: true)
        CATransaction.commit()
    }
    func pushViewController(viewController: UIViewController, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
}
