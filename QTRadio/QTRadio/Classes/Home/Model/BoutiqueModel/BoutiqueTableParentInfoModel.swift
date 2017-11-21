//
//  BoutiqueTableParentInfoModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/15.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


@objcMembers
class BoutiqueTableParentInfoModel: NSObject {

    // MARK: - 服务器返回的模型属性
    
    /// 主标题
    var parent_name: String = ""
    
    /// 对应评分机制和播放量中的id
    var parent_id: Int = 0
    
    
    // MARK: - 自定义构造函数
    
    /// 将字典转为模型
    init(dict: [String: Any]) {
        super.init()
        
        // 利用KVC将字典转为模型
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
