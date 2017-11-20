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
    
    /// 获取当前时间
    class func getCurrentTime() -> String {
        
        // 创建当前的时间
        let nowDate = NSDate()
        
        // 获取时间间隔(从1970年到现在一共有多少秒)
        let interval = Int(nowDate.timeIntervalSince1970)
        
        // 返回时间间隔
        return "\(interval)"
    }
    
    
    /// 处理时间戳
    /// - 参数timeString：表示服务器返回的时间戳字符串儿
    class func dealWith(timeString: String) -> String {
        
        // 处理服务器返回的时间字段。时间字符串儿中的大写字母
        // T表示时间，一般用创建时间格式化对象时，用'T'表示它
        //let timeString = "2017-11-27T07:21:00.000Z"  // 11月27日15：21
        
        // 创建时间格式化对象
        let dateFormatter = DateFormatter()
        
        // EEE: 表示星期
        // yyyy: 表示年
        // MM: 表示月
        // dd: 表示日
        // HH: 表示时
        // mm: 表示分
        // ss: 表示秒
        // Z: 表示时区  yyyy-MM-dd'T'HH:mm:ssZ
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"  // yyyy-MM-dd'T'HH:mm:ss.000Z
        dateFormatter.locale = Locale(identifier: "en")
        
        // 将字符串时间转化为Date类型
        guard let date = dateFormatter.date(from: timeString) else { return "" }
        
        // 创建当前时间
        let nowDate = Date()
        
        // 计算时间差
        let interval = date.timeIntervalSince(nowDate)
        
        // MARK: - 对时间差进行处理
        
        var time: String = ""
        
        // 创建日历对象
        let cal = Calendar.current
        
        // 判断是否是今天(这个对了)
        if cal.isDateInToday(date) {
            
            dateFormatter.dateFormat = "今天 HH:mm"
            time = dateFormatter.string(from: date)
        }
        
        // 判断是否是明天(这个也对了)
        if cal.isDateInTomorrow(date) {
            
            dateFormatter.dateFormat = "明天 HH:mm"
            time = dateFormatter.string(from: date)
        }
        
        
        // 判断是否是明天往后(这个也对了)
        if interval > 60 * 60 * 24 * 2 {
            
            dateFormatter.dateFormat = "MM月dd日 HH:mm"
            time = dateFormatter.string(from: date)
        }
        
        return time
    }
}
