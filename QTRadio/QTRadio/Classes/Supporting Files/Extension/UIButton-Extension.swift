//
//  UIButton-Extension.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// UIButton的扩展，根据给定的图片来创建相应的按钮

import UIKit


extension UIButton {
    
    /// 根据给定的图片创建自定义按钮
    /// - 参数image: 表示普通状态下的图片
    /// - 参数highlightedImage: 表示高亮状态下的图片。如果没有，可以不传
    convenience init(image: String, highlightedImage: String="") {
        
        self.init()
        
        // 设置按钮的图片
        setImage(UIImage(named: image), for: .normal)
        setImage(UIImage(named: highlightedImage), for: .highlighted)
        
        // 设置按钮的尺寸
        sizeToFit()
    }
}
