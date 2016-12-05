//
//  CollectionViewNormalCell.swift
//  ZBDY
//
//  Created by 古今 on 2016/11/24.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: CollectionBaseCell {
    // MARK: - 控件的属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    // MARK: - 定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            //1.将属性传递给父类
            super.anchor = anchor
            
            //2.房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }

}
