//
//  CollectionHeaderView.swift
//  ZBDY
//
//  Created by 古今 on 2016/11/24.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    // MARK: - 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK: - 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}
