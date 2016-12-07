
//
//  RecommendGameView.swift
//  ZBDY
//
//  Created by 古今 on 2016/12/7.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class RecommendGameView: UIView {

    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //让控件不随着父控件的拉伸而拉伸
        autoresizingMask = []
        
        //注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kGameCellID)
    }
}

// MARK: - 提供快速创建的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

// MARK: - 遵守UICollectionView的数据源协议
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath)
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        
        return cell
    }
}

