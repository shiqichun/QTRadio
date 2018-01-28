//
//  UIImageView-Extension.swift
//  QTRadio
//
//  Created by Enrica on 2018/1/28.
//  Copyright © 2018年 Enrica. All rights reserved.
//
// 为了方便使用Kingfisher，可以给UIImageView写一个分类
// 这样就不需要每次使用Kingfisher的时候都导入一次了

import UIKit
import Kingfisher

extension UIImageView {
    
    /// 使用Kingfisher设置图片
    /// -参数urlString: 表示图片的URL地址字符串
    func setImage(_ urlString: String?) {
        
        // 对地址字符串儿进行校验
        guard let urlString = urlString else { return }
        
        // 校验URL地址
        guard let url = URL(string: urlString) else { return }
        
        // 通过Kingfisher设置图片
        kf.setImage(with: url)
    }
}
