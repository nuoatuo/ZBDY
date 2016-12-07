//
//  CollectionCycleCell.swift
//  ZBDY
//
//  Created by 古今 on 2016/12/7.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    // MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
   // MARK: 定义模型属性
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = NSURL(string: cycleModel?.pic_url ?? "")!
            iconImageView.kf.setImage(with: ImageResource.init(downloadURL: iconURL as URL), placeholder: UIImage(named: "Img_default"))
        }
    }
    
}
