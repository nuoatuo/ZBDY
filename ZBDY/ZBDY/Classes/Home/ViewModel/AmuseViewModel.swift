//
//  AmuseViewModel.swift
//  ZBDY
//
//  Created by 古今 on 2016/12/9.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

class AmuseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension AmuseViewModel {
    func loadAmuseData(finishedCallback :  @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) in
            //1.获取到数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            //2.字典转模型
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            
            //3.完成回调
            finishedCallback()
        }
    }
}
