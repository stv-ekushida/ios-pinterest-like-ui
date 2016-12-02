//
//  UIStoryboard+ViewController.swift
//  pinterest-like-ui
//
//  Created by Eiji Kushida on 2016/12/02.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

extension UIStoryboard {

    static func getViewController<T: UIViewController>(storyboardName: String, identifier: String) -> T? {
        
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier) as? T
    }
}
