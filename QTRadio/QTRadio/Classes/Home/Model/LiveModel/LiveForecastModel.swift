//
//  LiveForecastModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/17.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 预约直播模型

import UIKit



@objcMembers
class LiveForecastModel: NSObject {
    
    
    // MARK: - 服务器返回的模型数据
    
    /// id
    var id: Int = 0
    
    /// title(配图下面第二行灰色标题)
    var title: String = ""
    
    /// cover(配图地址)
    var cover: String = ""
    
    /// scheduled_at(计划开播时间)
    var scheduled_at: String = ""
    
    /// liveshow_url(直播房间链接)
    var liveshow_url: String = ""
    
    /// last_week_rank(等级)
    var last_week_rank: Any?
    
    /// tag(身份标签)
    var tag: String = ""
    
    
    
    // MARK: - 自定义构造函数
    init(dict: [String: Any]) {
        super.init()
        
        // 利用KVC将字典转为模型
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
