//
//  NavBarModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/26.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


@objcMembers
class NavBarModel: NSObject {
    
    // MARK: - 服务器返回的模型属性
    
    /// 标题
    var title: String = ""
    
    /// urlScheme
    var urlScheme: String = ""
    
    /// 当前子控制器是否被选中
    var current: Bool = false
    
    // MARK: - 自定义构造函数
    
    /// 将字典转为模型
    init(dict: [String: Any]) {
        super.init()
        
        // 利用KVC将字典转为模型
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
