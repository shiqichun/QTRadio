//
//  IconGridModel.swift
//  多层嵌套JSON
//
//  Created by Enrica on 2017/11/13.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


@objcMembers
class IconGridModel: NSObject {
    
    
    // MARK: - 自定义的模型数组
    
    /// 用于存储转换完成的模型数据
    lazy var iconGridDataModelArray: [IconGridDataModel] = [IconGridDataModel]()
    
    // MARK: - 服务器返回的模型属性
    
    /// 类型
    var type: String = ""
    
    /// 字典数组
    var data: [String: Any]? {
        
        didSet {
            
            // 先对字典data中的数据进行校验
            guard let data = data else { return }
            
            // 直接将字典转换为模型
            let item = IconGridDataModel(dict: data)
            
            // 将转换完成的模型数据存储到数组中
            iconGridDataModelArray.append(item)
        }
    }
    
    
    // MAKR: - 自定义构造函数
    
    /// 将字典转为模型
    init(dict: [String: Any]) {
        super.init()
        
        // 利用KVC将字典转为模型
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
