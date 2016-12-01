//
//  RecommendViewModel.swift
//  ZBDY
//
//  Created by 古今 on 2016/12/1.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

class RecommendViewModel {
    // MARK: - 懒加载属性
    fileprivate lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

// MARK: - 发送网络请求
extension RecommendViewModel {
    func requestData() {
        //1.请求第一部分推荐数据
        
        //2. 请求第二部分颜值数据
        
        //3. 请求后面部分游戏数据
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1480575387
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime() as NSString]) { (result) in
                //1.将result转成字典类型
            guard  ((result as? [String : NSObject]) != nil) else { return }
            
            //2.根据data该key，获取数组
            guard (result["data"] as? [[String : NSObject]]) != nil else { return }
            
            //3.遍历数组，获取字典，并且将字典转成模型对象
            let dataArray = result["data"] as! [[String : NSObject]]
            for dict in dataArray {
                let group = AnchorGroup(dict: dict as [String : NSObject])
                self.anchorGroups.append(group)
            }
            
            for group in self.anchorGroups {
                for anchor in group.anchors {
                    print(anchor.nickname)
                }
                print("---------------")
            }
        }
    }
}
