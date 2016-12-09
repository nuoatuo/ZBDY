//
//  GameViewController.swift
//  ZBDY
//
//  Created by 古今 on 2016/12/8.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenWidth - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kHeaderViewH : CGFloat = 50
private let kGameViewH : CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"

class GameViewController: UIViewController {

    // MARK: 懒加载属性
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, kEdgeMargin, 0, kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderViewH)
        
        //2.创建UIViewController
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
       collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
       collectionView.dataSource = self
        
        return collectionView
    }()
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0.0, y: -(kGameViewH + kHeaderViewH), width: kScreenWidth, height: kHeaderViewH)
        headerView.titleLabel.text = "常用"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenWidth, height: kGameViewH)
        return gameView
    }()
    
    
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupUI()
        loadData()
    }

}

// MARK: - 设置UI界面
extension GameViewController {
    fileprivate func setupUI() {
        //1.添加collectionView
        view.addSubview(collectionView)
        
        //2.添加topHeaderView
        collectionView.addSubview(topHeaderView)
        
        //3.将常用游戏的View，添加到collectionView中
        collectionView.addSubview(gameView)
        
        //4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsetsMake(kGameViewH + kHeaderViewH, 0, 0, 0)
    }
}

// MARK: - 请求数据
extension GameViewController {
    fileprivate func loadData() {
        gameVM.loadAllGameData {
            //1.展示全部游戏
            self.collectionView.reloadData()
            
            //2.展示常用游戏（取前10条）
            self.gameView.groups = Array(self.gameVM.games[0..<10])
        }
    }
}

// MARK: - 遵守的数据源&代理
extension GameViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
       cell.baseGame = gameVM.games[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        //2.给headerView设置属性
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
    }
    
}

