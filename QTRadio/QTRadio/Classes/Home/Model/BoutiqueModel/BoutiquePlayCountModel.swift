//
//  BoutiquePlayCountModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/17.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit



@objcMembers
class BoutiquePlayCountModel: NSObject {
    
    // MARK: - 服务器返回的模型属性
    
    /// 播放次数
    var playcount: String = ""
    
    /// id
    var id: Int = 0
    
    /// 评分
    var score: Int = 0
    
    
    // MARK: - 自定义构造函数
    
    /// 将字典转为模型
    init(dict: [String: Any]) {
        super.init()
        
        // 利用KVC将字典转为模型
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
