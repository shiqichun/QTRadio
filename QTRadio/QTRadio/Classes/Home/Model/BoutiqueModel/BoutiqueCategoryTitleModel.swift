//
//  BoutiqueCategoryTitleModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/16.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


@objcMembers
class BoutiqueCategoryTitleModel: NSObject {

    
    // MARK: - 模型属性
    
    /// 标题
    var title: String = ""
    
    //// 是否需要小箭头
    var isHiddenArrow: Bool = false
    
    /// 是否需要设置darkGray
    var isLightGray: Bool = false
    
    
    // MARK: - 构造函数
    
    /// 自定义构造函数
    init(dict: [String: Any]) {
        super.init()
        
        // 利用KVC将字典转为模型
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
