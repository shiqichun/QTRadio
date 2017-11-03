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
    /// - 参数r：表示红颜色通道的数值
    /// - 参数g：表示绿颜色通道的数值
    /// - 参数b：表示蓝颜色通道的数值
    /// - 参数alpha：表示颜色的透明度，可以不传；如果不传，则表示不透明
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    /// 随机颜色
    /// - returns：返回一个随机颜色
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}
