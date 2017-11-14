//
//  BannerDataModel.swift
//  多层嵌套JSON
//
//  Created by Enrica on 2017/11/14.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


@objcMembers
class BannerDataModel: NSObject {
    
    // MARK: - 自定义模型数组
    
    /// 用于存储转换完成的模型数据
    lazy var bannerDataDataModelArray: [BannerDataDataModel] = [BannerDataDataModel]()
    
    // MARK: - 服务器返回的模型属性
    
    /// 行数
    var row: Int = 0
    
    /// 列数
    var col: Int = 0
    
    /// 数组数据 - 里面存储的是字典
    var data: [[String: Any]]? {
        
        didSet {
            
            // 首先校验数组data中的数据
            guard let data = data else { return }
            
            // 遍历数组，取出里面的字典
            for dict in data {
                
                // 将字典转为模型
                let item = BannerDataDataModel(dict: dict)
                
                // 将转换完成的模型数据存储到数组中
                bannerDataDataModelArray.append(item)
            }
        }
    }
    
    
    // MARK: - 自定义构造函数
    init(dict: [String: Any]) {
        super.init()
        
        // 利用KVC将字典转为模型
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
