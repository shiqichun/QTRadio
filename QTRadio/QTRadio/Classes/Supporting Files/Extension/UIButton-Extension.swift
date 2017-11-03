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
        if highlightedImage != "" {
            setImage(UIImage(named: highlightedImage), for: .highlighted)
        }
        
        // 设置按钮的尺寸
        sizeToFit()
    }
    
    
    /// 根据给定的图片和标题，创建一个带圆角的按钮
    /// - 参数imageName：表示普通状态下按钮的背景图片
    /// - 参数hightlightedImageName：表示高亮状态下按钮的背景图片，可以不传
    /// - 参数title：表示普通状态下按钮的标题
    /// - 参数hightlightedTitle：表示高亮状态下按钮的标题，可以不传
    convenience init(imageName: String, hightlightedImageName: String = "", title: String, hightlightedTitle: String = "") {
        
        self.init()
        
        // 设置按钮的背景图片
        setBackgroundImage(UIImage.imageWithStretchalbe(imageName), for: .normal)
        if hightlightedImageName != "" {
            setBackgroundImage(UIImage.imageWithStretchalbe(hightlightedImageName), for: .highlighted)
        }
        
        // 设置按钮的标题
        setTitle(title, for: .normal)
        if hightlightedTitle != "" {
            setTitle(hightlightedTitle, for: .highlighted)
        }
        
        // 设置按钮的圆角
        layer.cornerRadius = 5
        clipsToBounds = true
        
        // 设置按钮字体的大小
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
}



