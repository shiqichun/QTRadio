//
//  NSDate-Extension.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/5.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 获取当前的时间，并且将其转换为字符串

import Foundation


extension NSDate {
    
    class func getCurrentTime() -> String {
        
        // 创建当前的时间
        let nowDate = NSDate()
        
        // 获取时间间隔(从1970年到现在一共有多少秒)
        let interval = Int(nowDate.timeIntervalSince1970)
        
        // 返回时间间隔
        return "\(interval)"
    }
}
