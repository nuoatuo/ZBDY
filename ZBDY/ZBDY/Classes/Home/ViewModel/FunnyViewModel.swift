//
//  FunnyViewModel.swift
//  ZBDY
//
//  Created by 古今 on 2016/12/9.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

class FunnyViewModel  : BaseViewModel{
}

extension FunnyViewModel {
    
    //http://capi.douyucdn.cn/api/v1/getColumnRoom/3?limit=30&offset=0
    func loadFunnyData(finishedCallback :  @escaping () -> ()) {
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
    }
}
