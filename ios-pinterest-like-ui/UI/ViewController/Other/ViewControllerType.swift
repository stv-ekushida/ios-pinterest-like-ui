//
//  ViewControllerType.swift
//  pinterest-like-ui
//
//  Created by Eiji Kushida on 2016/12/02.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

protocol ViewControllerType {

    func createVC() -> UIViewController?
    func setupParam(vc: UIViewController, param: Any)
}
