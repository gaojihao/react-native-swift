//
//  LZNavigationController.swift
//  react-native-swift
//
//  Created by Saiki on 2023/5/16.
//

import UIKit

class LZNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
