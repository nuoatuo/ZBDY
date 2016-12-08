//
//  BaseGameModel.swift
//  ZBDY
//
//  Created by 古今 on 2016/12/8.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    // MARK: 定义属性
     //组显示的标题
    var tag_name : String = ""
    //游戏对应的图标
    var icon_url : String = ""
    
    // MARK: 自定义构造函数
    override init() {
    }
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
