//
//  RecommendDataModel.swift
//  多层嵌套JSON
//
//  Created by Enrica on 2017/11/14.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


@objcMembers
class RecommendDataModel: NSObject {
    
    // MARK: - 自定义的模型数组
    
    /// 用于将转换完成的模型数据存储起来
    lazy var recommendDataDataModelArray: [RecommendDataDataModel] = [RecommendDataDataModel]()
    
    
    // MARK: - 服务器返回的模型属性
    
    /// 标题
    var title: String = ""
    
    /// 数组数据
    var data: [[String: Any]]? {
        
        didSet {
            
            // 首先校验数组data是否有值
            guard let data = data else { return }
            
            // 遍历数组中的字典
            for dict in data {
                
                // 将字典转为模型
                let item = RecommendDataDataModel(dict: dict)
                
                // 将转换完成的模型数据存储到数组中
                recommendDataDataModelArray.append(item)
            }
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
