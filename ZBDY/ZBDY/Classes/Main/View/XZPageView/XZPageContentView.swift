//
//  XZPageContentView.swift
//  ZBDY
//
//  Created by 古今 on 2016/11/22.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

private let kContentCellID = "ContentCellID"

class XZPageContentView: UIView {
    // MARK: - 定义属性
    fileprivate var childVCArray : [UIViewController]
    fileprivate weak var parentVC : UIViewController?
    
    // MARK: - 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.scrollDirection = .horizontal
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        return collectionView
    }()
    
    // MARK: - 自定义构造函数
    init(frame: CGRect, childVCArray : [UIViewController], parentVC : UIViewController?) {
        self.childVCArray = childVCArray
        self.parentVC = parentVC
        
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - 设置UI界面
extension XZPageContentView {
    fileprivate func setupUI() {
        //1.将所有的子控制器添加到父控制器中
        for childVC in childVCArray {
            parentVC?.addChildViewController(childVC)
        }
        
        //2.添加UICollectionView, 用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}

// MARK: - 遵守UICollectionViewDataSource
extension XZPageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childVCArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        
        //2.给Cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVCArray[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

// MARK: - 对外暴露的方法
extension XZPageContentView {
    
    //设置当前下标
    func setCurrentIndex(currentIndex : Int) {
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        
    }
}
