//
//  RecommendCycleView.swift
//  ZBDY
//
//  Created by 古今 on 2016/12/6.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    
    // MARK: 定义属性
    var cycleTimer : Timer?
    var cycleModels : [CycleModel]? {
        didSet {
            //1.刷新collectionView
            collectionView.reloadData()
            
            //2.设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //3.默认滚动到中间某一个位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
           collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            //4.添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    // MARK:  控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK:  系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = []
        
        //注册Cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
//        layout.minimumLineSpacing = 0.0
//        layout.minimumInteritemSpacing = 0.0
//        //设置滚动方向
//        layout.scrollDirection = .horizontal
//        //设置按页滚动
//        collectionView.isPagingEnabled = true
    }
}

// MARK: - 提供一个快速创建View的类方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

// MARK: - 遵守UICollectionView的数据源协议
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0)*10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        return cell
    }
}

// MARK: - 遵守UICollectionView的代理协议
extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         //1.获取滚动的偏移量(滚到一半就显示下一个)
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width*0.5
        
        //2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

// MARK: - 对定时器的操作方法
extension RecommendCycleView {
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)    }
    
    fileprivate func removeCycleTimer() {
        //从运行循环中移除
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext() {
        //1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        //2.滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0.0), animated: true)
    }
}

