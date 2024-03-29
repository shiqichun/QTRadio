//
//  BoutiqueTableDetailModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/16.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit



@objcMembers
class BoutiqueTableDetailModel: NSObject {

    
    // MARK: - 服务器返回的模型属性
    
    /// 主标题
    var title: String = ""
    
    /// 详情链接地址
    var url: String = ""
    
    
    // MARK: - 自定义的构造函数
    
    /// 将字典转为模型
    init(dict: [String: Any]) {
        super.init()
        
        // 利用KVC将字典转为模型
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
