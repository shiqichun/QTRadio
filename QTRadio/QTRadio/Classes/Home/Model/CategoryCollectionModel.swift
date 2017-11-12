//
//  CategoryCollectionModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/10.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

@objcMembers
class CategoryCollectionModel: NSObject {
    
    // MARK: - 模型属性
    
    /// 图片名称
    var imageName: String = ""
    
    
    /// 标题名称
    var title: String = ""
    
    
    // MARK: - 自定义构造函数
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
