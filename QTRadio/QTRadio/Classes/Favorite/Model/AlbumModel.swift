//
//  AlbumModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/4.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 收藏模块主控制器中的专辑模型

import UIKit

/// Swift 4以后，利用KVC字典转模型，前面一定
/// 要加上关键字@objcMembers，否则所有的键值
/// 匹配都会失效
@objcMembers
class AlbumModel: NSObject {

    // MARK: - 固定的属性
    
    // rec_words：标题文本
    var rec_words: String = ""
    
    // rec_thumb：图片地址
    var rec_thumb: String = ""
    
    
    // MARK: - 自定义构造函数
    
    /// 传入一个字典，自动将其转为模型
    /// - 参数dict：表示传入的字典
    init(dict: [String: Any]) {
        super.init()
        
        // 使用KVC将字典转为模型
        setValuesForKeys(dict)
    }
    
    /// 因为请求的数据中，有一些键并没有用到，为了防止其报错，必须重写下面这个方法
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
