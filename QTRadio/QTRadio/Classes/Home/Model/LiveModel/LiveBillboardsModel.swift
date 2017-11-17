//
//  LiveBillboardsModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/17.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


@objcMembers
class LiveBillboardsModel: NSObject {
    
    
    // MARK: - 模型数组
    
    /// 用于存储转换完成的items模型
    lazy var billboardsItemsModelArray = [LiveBillboardsItemsModel]()
    
    
    
    // MARK: - 服务器返回的模型数据
    
    /// 类型
    var type: String = ""
    
    
    /// items数组数据
    var items: [[String: Any]]? {
        
        didSet {
            
            // 先校验数组items是否有值
            guard let items = items else { return }
            
            // 遍历数组，取出字典
            for dict in items {
                
                // 将字典转为模型
                let item = LiveBillboardsItemsModel(dict: dict)
                
                // 将转换完成的模型数据保存到模型数组中
                billboardsItemsModelArray.append(item)
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
