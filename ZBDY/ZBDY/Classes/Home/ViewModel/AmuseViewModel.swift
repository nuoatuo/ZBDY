//
//  AmuseViewModel.swift
//  ZBDY
//
//  Created by 古今 on 2016/12/9.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel {
  
}

extension AmuseViewModel {
    func loadAmuseData(finishedCallback :  @escaping () -> ()) {
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
