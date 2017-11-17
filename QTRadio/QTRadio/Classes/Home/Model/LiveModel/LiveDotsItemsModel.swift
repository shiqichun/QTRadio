//
//  LiveDotsItemsModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/17.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


@objcMembers
class LiveDotsItemsModel: NSObject {
    
    
    // MARK: - 服务器返回的模型数据
    
    /// type
    var type: String = ""
    
    /// img_url(配图地址)
    var img_url: String = ""
    
    /// name(配图上显示的文字)
    var name: String = ""
    
    /// redirect_url
    var redirect_url: String = ""
    

    
    // MARK: - 自定义构造函数
    init(dict: [String: Any]) {
        super.init()
        
        // 利用KVC将字典转为模型
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
