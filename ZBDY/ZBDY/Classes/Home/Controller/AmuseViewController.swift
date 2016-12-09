//
//  AmuseViewController.swift
//  ZBDY
//
//  Created by 古今 on 2016/12/9.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {

    // MARK: - 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenWidth, height: kMenuViewH)
        
        return menuView
    }()
}

// MARK: - 设置UI界面
extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        
        //将菜单View添加到collectionView中
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsetsMake(kMenuViewH, 0, 0, 0)
    }
}


// MARK: - 请求数据
extension AmuseViewController {
    override func loadData() {
        //1.给父类中的ViewModel进行赋值
        baseVM = amuseVM
        
        //2.请求数据
        amuseVM.loadAmuseData {
            //刷新数据
            self.collectionView.reloadData()
            
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
        }
    }
}



