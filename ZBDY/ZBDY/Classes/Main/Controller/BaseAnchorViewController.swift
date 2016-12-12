//
//  BaseAnchorViewController.swift
//  ZBDY
//
//  Created by 古今 on 2016/12/9.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

//间距
private let kItemMargin : CGFloat = 10


private let kHeaderViewH : CGFloat = 50.0

private let kNormalCellID = "NormalCellID"
private let kHeaderViewID = "HeaderViewID"

let kPrettyCellID = "PrettyCellID"
let kNormalItemWidth : CGFloat = (kScreenWidth - 3 * kItemMargin) / 2
let kNormalItemHeight : CGFloat = kNormalItemWidth * 3 / 4
let kPrettyItemHeight : CGFloat = kNormalItemWidth * 4 / 3

class BaseAnchorViewController : BaseViewController {
    
    // MARK: - 定义属性
    var baseVM : BaseViewModel!
    lazy var collectionView : UICollectionView = { [unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemWidth, height: kNormalItemHeight)
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
    
    
    // MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
}

// MARK: - 设置UI界面内容
extension BaseAnchorViewController {
    override func setupUI() {
        //1.给父类中内容View的引用进行赋值
        contentView = collectionView
        
        //2.添加collectionView
        view.addSubview(collectionView)
        
        //3.调用setupUI()
        super.setupUI()
    }
}

// MARK: - 请求数据
extension BaseAnchorViewController {
    func loadData() {
    }
}

// MARK: - 遵守UICollectionViewDataSource的数据源
extension BaseAnchorViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出Cell
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
        
        //2.给Cell设置数据
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        //2.给HeaderView设置数据
        headerView.group = baseVM.anchorGroups[indexPath.section];
        
        return headerView
    }
    
}

// MARK: - 遵守UICollectionViewDelegate的代理协议
extension BaseAnchorViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //1.取出对应的主播信息
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        //2.判断是秀场房间||普通房间
        anchor.isVertical == 0 ? pushNormalRoomVC() : presentShowRoomVC()
    }
    
    private func presentShowRoomVC() {
        //1.创建showRoomVC
        let showRoomVC = RoomShowViewController()
        
        //2.以Modal方式弹出
        present(showRoomVC, animated: true, completion: nil)
    }
    
    private func pushNormalRoomVC() {
        //1.创建normalRoomVC
        let normalRoomVC = RoomNormalViewController()
        
        //2.以push方式弹出
        navigationController?.pushViewController(normalRoomVC, animated: true)
    }
    
}
