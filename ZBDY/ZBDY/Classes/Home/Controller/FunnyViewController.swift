//
//  FunnyViewController.swift
//  ZBDY
//
//  Created by 古今 on 2016/12/9.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

private let kTopMargin : CGFloat = 8

class FunnyViewController: BaseAnchorViewController {
    // MARK: 懒加载ViewModel对象
    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()
}

extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsetsMake(kTopMargin, 0, 0, 0)
    }
}

extension FunnyViewController {
    override func loadData() {
        //1.给父类中的ViewModel进行赋值
        baseVM = funnyVM
        
        //2.请求数据
        funnyVM.loadFunnyData {
            //2.1刷新表格
            self.collectionView.reloadData()
            
            //2.2.数据请求完成
            self.loadDataFinished()
        }
    }
}

