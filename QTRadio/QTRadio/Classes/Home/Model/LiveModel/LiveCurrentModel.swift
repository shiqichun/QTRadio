//
//  LiveCurrentModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/17.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit



@objcMembers
class LiveCurrentModel: NSObject {

    // MARK: - 服务器返回的模型属性
    
    /// id
    var id: Int = 0
    
    /// title(配图下面灰色的小标题)
    var title: String = ""
    
    /// cell的配图
    var cover: String = ""
    
    /// started_at(开播时间，在系统返回时间的基础上+8：00)
    var started_at: String = ""
    
    /// scheduled_at(计划开播时间，一般为空)
    var scheduled_at: String = ""
    
    // MARK: - 自定义构造函数
    
    /// 将字典转为模型
    init(dict: [String: Any]) {
        super.init()
        
        // 利用KVC将字典转为模型
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
