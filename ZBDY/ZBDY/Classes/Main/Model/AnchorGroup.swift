//
//  AnchorGroup.swift
//  ZBDY
//
//  Created by 古今 on 2016/12/1.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    //该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }

    //组显示的图标
    var icon_name : String = "home_header_normal"
    //定义主播的模型对象的数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
}
