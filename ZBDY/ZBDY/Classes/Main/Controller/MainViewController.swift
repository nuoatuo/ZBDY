//
//  MainViewController.swift
//  ZBDY
//
//  Created by 古今 on 2016/11/18.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC("Home")
        addChildVC("Live")
        addChildVC("Follow")
        addChildVC("Profile")
    }

    fileprivate func addChildVC(_ storyboardName : String) {
        //1.通过storyboard获取控制器
        let childVC = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!
        
        //2.将childVC作为子控制器
        addChildViewController(childVC)
    }
}
