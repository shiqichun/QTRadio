//
//  IconGridDataDataModel.swift
//  多层嵌套JSON
//
//  Created by Enrica on 2017/11/14.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


@objcMembers
class IconGridDataDataModel: NSObject {
    
    // MARK: - 服务器返回的模型属性
    
    /// 标题
    var title: String = ""
    
    /// 配图地址
    var imgUrl: String = ""
    
    /// 不知道啥玩意儿
    var urlScheme: String = ""
    
    
    // MARK: - 自定义构造函数
    
    /// 将字典转为模型
    init(dict: [String: Any]) {
        super.init()
        
        // 利用KVC将字典转为模型
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
