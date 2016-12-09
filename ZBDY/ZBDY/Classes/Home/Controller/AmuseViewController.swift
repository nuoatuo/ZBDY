//
//  AmuseViewController.swift
//  ZBDY
//
//  Created by 古今 on 2016/12/9.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit



class AmuseViewController: BaseAnchorViewController {

    // MARK: - 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
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
        }
    }
}



