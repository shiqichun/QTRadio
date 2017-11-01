//
//  UIColor-Extension.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// UIColor的扩展，根据RGB来创建相应的颜色

import UIKit


extension UIColor {
    
    /// RGB(如果在构造函数中设置默认值，那么系统会帮你生成两个构造函数)
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    /// 随机颜色
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    /// 对十六进制颜色进行处理
    convenience init?(hex: String, alpha: CGFloat = 1.0) {  // 构造函数后面加?号，表示可能创建出来，也可能创建不出来
        
        // 对十六进制字符串儿的长度进行校验
        guard hex.characters.count >= 6 else {
            
            // 如果长度不大于6位，就直接返回nil
            return nil
        }  // 一般情况下，构造函数是没有返回值的，但是可选类型的构造函数是可以的
        
        // 如果十六进制字符串为小写，需要将其转成大写
        var tmpHex = hex.uppercased()
        
        // 判断开头(代码在这里有一点问题，就是以0x开头的字符串儿到了这里就无法识别了)
        if tmpHex.hasPrefix("0x") || tmpHex.hasPrefix("##") {  // 如果是以0x或者##开头
            
            // 先转成NSString，然后再从第2个位置开始往后截取字符串
            tmpHex = (tmpHex as NSString).substring(from: 2)
        }
        if tmpHex.hasPrefix("#") {  // 如果是以#开头
            // 截取字符串
            tmpHex = (tmpHex as NSString).substring(from: 1)
        }
        
        // 分别取出RGB
        var range = NSRange(location: 0, length: 2)  // R红色的范围
        let rHex = (tmpHex as NSString).substring(with: range)  // 取出红色的字符串儿
        range.location = 2  // 长度依然是2，但是是从第2个位置开始取
        let gHex = (tmpHex as NSString).substring(with: range)  // 取出绿色的字符串儿
        range.location = 4  // 长度依然是2，从第4个位置开始取
        let bHex = (tmpHex as NSString).substring(with: range)  // 取出蓝色的字符串儿
        
        /**
         *  上面取出来的rHex、gHex和bHex都是FF这种形式，需要将其转为RGB(也就是255)
         */
        
        // 将十六进制转成数字，跟转emoji表情的思路一致
        var r : UInt32 = 0, g : UInt32 = 0, b : UInt32 = 0
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        /**
         *  Scanner(string: rHex)表示创建扫描器，然后将需要扫描的字符串传进去；
         *  scanHexInt32(&r)表示扫描成十六进制数字，需要将扫描结果通过指针传给r变量。
         */
        
        // 将已经扫描成功的r、g和b传给构造函数
        self.init(r : CGFloat(r), g : CGFloat(g), b : CGFloat(b))  // 需要将UInt32转成CGFloat
    }
}
