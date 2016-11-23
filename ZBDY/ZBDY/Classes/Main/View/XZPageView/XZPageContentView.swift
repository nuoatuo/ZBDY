//
//  XZPageContentView.swift
//  ZBDY
//
//  Created by 古今 on 2016/11/22.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

protocol XZPageContentViewDelegate : class {
    func pageContentView(contentView : XZPageContentView, progress : CGFloat, sourceIndex : Int,  targetIndex : Int)
}

private let kContentCellID = "ContentCellID"

class XZPageContentView: UIView {
    // MARK: - 定义属性
    //子控制器数据源
    fileprivate var childVCArray : [UIViewController]
    //父控制器
    fileprivate weak var parentVC : UIViewController?
    //开始偏移X
    fileprivate var startOffsetX : CGFloat = 0.0
    //是否禁止滚动代理
    fileprivate var isForbidScrollDelegate : Bool = false
    //代理
    weak var delegate : XZPageContentViewDelegate?
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
        collectionView.delegate = self as UICollectionViewDelegate?
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

// MARK: - 遵守UICollectionViewDelegate协议
extension XZPageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        
       //1.定义获取需要的数据
        //进度
        var progress : CGFloat = 0.0
        //来源下标
        var sourceIndex : Int = 0
        //目标下标
        var targetIndex : Int = 0
        
        //2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        //左滑进度
        let leftProgress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
        
        if currentOffsetX > startOffsetX {//左滑
            
            //1.计算progress
            progress = leftProgress
            
            //2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            //3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCArray.count  {
                targetIndex = childVCArray.count  - 1
            }
            
            //4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1.0
                targetIndex = sourceIndex
            }
            
        } else {//右滑
            //1.计算progress
            progress = 1 - leftProgress
            
            //2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            //3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCArray.count {
                sourceIndex = childVCArray.count - 1
            }
        }
        
        //3.将progress/sourceIndex/targetIndex传递给titleView
        //print("progress:\(progress)  sourceIndex:\(sourceIndex)  targetIndex:\(targetIndex)")
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK: - 对外暴露的方法
extension XZPageContentView {
    
    //设置当前下标
    func setCurrentIndex(currentIndex : Int) {
        //1.记录需要禁止执行代理方法
        isForbidScrollDelegate = true
        
        //2.滚动到正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        
    }
}
