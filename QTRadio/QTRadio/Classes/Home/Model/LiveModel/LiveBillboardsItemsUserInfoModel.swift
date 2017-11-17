//
//  LiveBillboardsItemsUserInfoModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/17.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit



@objcMembers
class LiveBillboardsItemsUserInfoModel: NSObject {

    
    // MARK: - 服务器返回的模型数据
    
    /// user_id
    var user_id: String = ""
    
    /// 用户头像avatar地址
    var avatar: String = ""
    
    
    
    
    // MARK: - 自定义构造函数
    init(dict: [String: Any]) {
        super.init()
        
        // 利用KVC将字典转为模型
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
