//
//  NSDate-Extension.swift
//  ZBDY
//
//  Created by 古今 on 2016/12/1.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
