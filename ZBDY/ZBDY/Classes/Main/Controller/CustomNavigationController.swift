//
//  CustomNavigationController.swift
//  ZBDY
//
//  Created by 古今 on 2016/12/12.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //隐藏要push的控制器tabbar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    
    }

}
