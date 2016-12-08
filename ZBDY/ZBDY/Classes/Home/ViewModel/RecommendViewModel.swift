//
//  RecommendViewModel.swift
//  ZBDY
//
//  Created by 古今 on 2016/12/1.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

/**
 1>请求0/1数组，并转成模型对象
 2>对数据进行排序
 3>显示的HeaderView中内容
 */

import UIKit

class RecommendViewModel {
    // MARK: - 懒加载属性
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    fileprivate lazy var bigDataGroups : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroups : AnchorGroup = AnchorGroup()
}

// MARK: - 发送网络请求
extension RecommendViewModel {
    
    //请求推荐数据
    func requestData(_ finishCallback : @escaping () -> ()) {
        //一.定义参数
        /*
         参数说明
         time: 获取当前时间的字符串
         limit: 获取数据的个数
         offset: 偏移的数据量
         */
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime() as NSString]
        
        //二、创建Group
        let dGroup = DispatchGroup()
        
        
        //三.请求第一部分推荐数据
        dGroup.enter()
        //http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1480575387
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime() as NSString]) { (result) in
            //1.将result转成字典类型
            guard  ((result as? [String : NSObject]) != nil) else { return }
            
            //2.根据data该key，获取数组
            guard (result["data"] as? [[String : NSObject]]) != nil else { return }
            
            //3.遍历数组，获取字典，并且将字典转成模型对象
            //3.1设置组的属性
            self.bigDataGroups.tag_name = "热门"
            self.bigDataGroups.icon_name = "home_header_hot"
            
            //3.2获取主播数据
            let dataArray = result["data"] as! [[String : NSObject]]
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroups.anchors.append(anchor)
            }
            
            //3.3离开组
            dGroup.leave()
             //print("请求到0组数据")
        }
        
        //四. 请求第二部分颜值数据
        dGroup.enter()
        //http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1480575387
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            //1.将result转成字典类型
            guard  ((result as? [String : NSObject]) != nil) else { return }
            
            //2.根据data该key，获取数组
            guard (result["data"] as? [[String : NSObject]]) != nil else { return }
            
            //3.遍历数组，获取字典，并且将字典转成模型对象
            //3.1设置组的属性
            self.prettyGroups.tag_name = "颜值"
            self.prettyGroups.icon_name = "home_header_phone"
            
            //3.2获取主播数据
            let dataArray = result["data"] as! [[String : NSObject]]
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroups.anchors.append(anchor)
            }
            
            //3.3离开组
            dGroup.leave()
             //print("请求到1组数据")
        }
        
        //五. 请求2-12部分游戏数据
        dGroup.enter()
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1480575387
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters:parameters) { (result) in
            //1.将result转成字典类型
            guard  ((result as? [String : NSObject]) != nil) else { return }
            
            //2.根据data该key，获取数组
            guard (result["data"] as? [[String : NSObject]]) != nil else { return }
            
            //3.遍历数组，获取字典，并且将字典转成模型对象
            let dataArray = result["data"] as! [[String : NSObject]]
            for dict in dataArray {
                let group = AnchorGroup(dict: dict as [String : NSObject])
                guard group.anchors.count != 0 else { continue }
                
                self.anchorGroups.append(group)
            }
            
            //4离开组
            dGroup.leave()
            //print("请求到2-12组数据")
        }
        
        //六.所有的数据都请求到，之后进行排序
        dGroup.notify(queue: DispatchQueue.main) { 
             //print("所有的数据都请求到")
            self.anchorGroups.insert(self.prettyGroups, at: 0)
            self.anchorGroups.insert(self.bigDataGroups, at: 0)
            
            finishCallback()
        }
        
    }
    
    //请求无限轮播的数据
    func requestCycleData(_ finishCallback : @escaping () -> ()) {
        //version:当前版本号
        //http://www.douyutv.com/api/v1/slide/6?version=2.300
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            //1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            //2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //3.字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finishCallback()
        }
    }
}
