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
private let kNormalItemHeight : CGFloat = kItemWidth * 3 / 4
private let kPrettyItemHeight : CGFloat = kItemWidth * 4 / 3
private let kHeaderViewH : CGFloat = 50.0

private let kCycleViewH = kScreenWidth * 3 / 8
private let kGameViewH : CGFloat = 90.0

private let kNormalCellID = "NormalCellID"
private let kPrettyCellID = "PrettyCellID"
private let kHeaderViewID = "HeaderViewID"

class RecommendViewController: UIViewController {

    // MARK: - 懒加载属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kNormalItemHeight)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsetsMake(0.0, kItemMargin, 0.0, kItemMargin)
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
      collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        return collectionView;
    
    }()
    
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0.0, y: -(kCycleViewH + kGameViewH), width: kScreenWidth, height: kCycleViewH)
        return cycleView
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0.0, y: -kGameViewH, width: kScreenWidth, height: kGameViewH)
        return gameView
    }()
    
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
        
        //发送网络请求
        loadData()
    }
    
}

// MARK: - 请求数据
extension RecommendViewController {
    fileprivate func loadData() {
        //1.请求推荐数据
        recommendVM.requestData { 
            self.collectionView.reloadData()
        }
        
        //2.请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

// MARK: - 设置UI界面内容
extension RecommendViewController {
    fileprivate func setupUI() {
        //1.将UICollectionView添加到控制器的View中
        view.addSubview(collectionView)
        
        //2.将cycleView添加到CollectionView中
        collectionView.addSubview(cycleView)
        
        //3.将gameView添加中collectionView
        collectionView.addSubview(gameView)
        
        //4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH, 0.0, 0.0, 0.0)

    }
}

// MARK: - 遵守UICollectionViewDataSource的数据协议
extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section];
        let anchor = group.anchors[indexPath.item];
        
        //2.定义Cell
        var cell : CollectionBaseCell!
        
        //3.取出Cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
        }
        
        //4.将模型赋值给Cell
        cell.anchor = anchor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        //2.取出模型
        headerView.group = recommendVM.anchorGroups[indexPath.section];
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemWidth, height: kPrettyItemHeight)
        } else {
            return CGSize(width: kItemWidth, height: kNormalItemHeight)
        }
    }
    
}

