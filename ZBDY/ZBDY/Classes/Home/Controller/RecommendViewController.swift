//
//  RecommendViewController.swift
//  ZBDY
//
//  Created by 古今 on 2016/11/23.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

//间距
private let kItemMargin : CGFloat = 10
private let kItemWidth : CGFloat = (kScreenWidth - 3 * kItemMargin) / 2
private let kItemHeight : CGFloat = kItemWidth * 3 / 4
private let kHeaderViewH : CGFloat = 50.0

private let kNormalCellID = "NormalCellID"
private let kHeaderViewID = "HeaderViewID"

class RecommendViewController: UIViewController {

    // MARK: - 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kItemHeight)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsetsMake(0.0, kItemMargin, 0.0, kItemMargin)
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
      
        return collectionView;
    
    }()
    
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
   
        
        //设置UI界面
        setupUI()
    }
    
}

// MARK: - 设置UI界面内容
extension RecommendViewController {
    fileprivate func setupUI() {
        //1.将UICollectionView添加到控制器的View中
        view.addSubview(collectionView)
        
        

    }
}

// MARK: - 遵守UICollectionViewDataSource的数据协议
extension RecommendViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {return 8}
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.获取Cell
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        
        return headerView
    }
    
}

