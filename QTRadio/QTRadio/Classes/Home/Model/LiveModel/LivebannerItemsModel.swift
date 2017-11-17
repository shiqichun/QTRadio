//
//  LivebannerItemsModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/17.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit



@objcMembers
class LivebannerItemsModel: NSObject {
    
    
    // MARK: - 服务器返回的模型数据

    /// id
    var id: Int = 0
    
    /// banner的配图
    var cover: String = ""
    
    /// banner的标题(一般不显示)
    var title: String = ""
    
    /// redirect_url
    var redirect_url: String = ""
    
    /// type
    var type: String = ""
    
    
    
    
    // MARK: - 自定义构造函数
    init(dict: [String: Any]) {
        super.init()
        
        // 利用KVC将字典转为模型
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
