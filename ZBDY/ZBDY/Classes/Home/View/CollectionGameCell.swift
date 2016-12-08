//
//  CollectionGameCell.swift
//  ZBDY
//
//  Created by 古今 on 2016/12/7.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {

    // MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            
            if let iconURL = URL(string: group?.icon_url ?? "") {
                iconImageView.kf.setImage(with: iconURL)
            } else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    // MARK:  系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
