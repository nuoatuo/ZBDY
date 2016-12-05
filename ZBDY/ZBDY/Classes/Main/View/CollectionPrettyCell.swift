//
//  CollectionPrettyCell.swift
//  ZBDY
//
//  Created by 古今 on 2016/11/24.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit


class CollectionPrettyCell: CollectionBaseCell {

    // MARK: - 控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    // MARK: - 定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            //1.将属性传递给父类
            super.anchor = anchor
          
            //2.所在城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
}
