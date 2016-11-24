//
//  HomeViewController.swift
//  ZBDY
//
//  Created by 古今 on 2016/11/18.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

//标题视图高
private let kTitleViewH : CGFloat = 40.0

class HomeViewController: UIViewController {
    // MARK: - 懒加载属性
    fileprivate lazy var pageTitleView : XZPageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0.0, y: kStatusBarH + kNavigationBarH, width: kScreenWidth, height: kTitleViewH)
        let titlesArray = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = XZPageTitleView(frame: titleFrame, titlesArray: titlesArray)
        titleView.delegate = self as XZPageTitleViewDelegate?
        return titleView
    }()
    
    fileprivate lazy var pageContentView : XZPageContentView = { [weak self] in
        //1.确定内容的frame
       let contentH = kScreenHeight  - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0.0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenWidth, height: contentH)
        //2. 确定所有的子控制器
        var childVCArray = [UIViewController]()
        childVCArray.append(RecommendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCArray.append(vc)
        }
        
        let contentView = XZPageContentView(frame: contentFrame, childVCArray: childVCArray, parentVC: self)
        contentView.delegate = self as XZPageContentViewDelegate?
        return contentView
    }()
    
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
    
    }
    
}

// MARK: - 设置UI界面
extension HomeViewController {
    
    //设置UI界面
    fileprivate func setupUI(){
        //0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //1.设置导航栏
        setupNavigationBar()
        
        //2.添加titleView
        view.addSubview(pageTitleView)
        
        //3.添加pageContentView
        view.addSubview(pageContentView)
    }
    
    //设置导航栏
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

// MARK: - 遵守XZPageTitleViewDelegate协议
extension HomeViewController : XZPageTitleViewDelegate {
    func pageTitleView(titleView: XZPageTitleView, selectedIndex index: Int) {
       pageContentView .setCurrentIndex(currentIndex: index)
    }
}

// MARK: - 遵守XZPageContentViewDelegate协议
extension HomeViewController : XZPageContentViewDelegate {
    func pageContentView(contentView: XZPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView .setTitle(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
