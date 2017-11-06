//
//  DailyModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/5.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


@objcMembers
class DailyModel: NSObject {
    
    
    // MARK: - 服务器返回的模型属性
    
    /// 顶部标题
    var title: String = ""
    
    /// 主标题
    var channel_title: String = ""
    
    /// 分类
    var category_name: String = ""
    
    /// 播放次数
    var playcount: String = ""
    
    /// 配图地址
    var img_url: String = ""
    
    /// 正文
    var desc: String = ""
    
    
    // MARK: - 自定义构造函数
    
    /// 利用KVC将字典转为模型
    init(dict: [String: Any]) {
        super.init()
        
        // 利用KVC将字典转为模型
        setValuesForKeys(dict)
    }
    
    /// 处理未定义的key
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
