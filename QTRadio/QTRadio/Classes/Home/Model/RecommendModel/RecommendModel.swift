//
//  RecommendModel.swift
//  多层嵌套JSON
//
//  Created by Enrica on 2017/11/14.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


@objcMembers
class RecommendModel: NSObject {
    
    // MARK: - 自定义的模型数组
    
    /// 用于将转换完成的模型数据存储到数组中
    lazy var recommendDataModelArray: [RecommendDataModel] = [RecommendDataModel]()
    
    
    // MARK: - 服务器返回的模型属性
    
    /// 类型
    var type: String = ""
    
    /// 字典数据
    var data: [String: Any]? {
        
        didSet {
            
            // 先校验字典data中是否有数据
            guard let data = data else { return }
            
            // 将字典转为模型
            let item = RecommendDataModel(dict: data)
            
            // 将转换完成的模型数据存储到数组中
            recommendDataModelArray.append(item)
        }
    }
    
    
    // MARK: - 自定义构造函数

    /// 将字典转为模型
    init(dict: [String: Any]) {
        super.init()
        
        // 利用KVC将字典转为模型
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
