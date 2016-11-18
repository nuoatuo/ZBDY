//
//  HomeViewController.swift
//  ZBDY
//
//  Created by 古今 on 2016/11/18.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
        setupUI()
      
    }

}

// MARK: - 设置UI界面
extension HomeViewController {
    fileprivate func setupUI(){
        //1.设置导航栏
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
        
        //1、设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
    
        //2、设置右侧的Item
        let size = CGSize(width: 40.0, height: 40.0)
        let historyItem =  UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
}
