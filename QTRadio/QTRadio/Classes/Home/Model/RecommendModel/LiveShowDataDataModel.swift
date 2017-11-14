//
//  LiveShowDataDataModel.swift
//  多层嵌套JSON
//
//  Created by Enrica on 2017/11/14.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


@objcMembers
class LiveShowDataDataModel: NSObject {

    
    // MARK: - 服务器返回的模型属性
    
    
    /// 标题
    var title: String = ""
    
    /// 描述文字
    var recWords: String = ""
    
    /// 配图地址
    var imgUrl: String = ""
    
    /// 播放量
    var playCnt: Int = 0
    
    /// 积分
    var score: Int = 0
    
    /// 不知道是啥玩意儿
    var urlScheme: String = ""
    
    /// 是否免费
    var free: Bool = true
    
    /// 标签
    var tag: String = ""
    
    
    // MARK: - 自定义构造函数
    
    /// 将字典转为模型
    init(dict: [String: Any]) {
        super.init()
        
        // 利用KVC将字典转为模型
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
