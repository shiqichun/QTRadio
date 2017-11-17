//
//  LiveBillboardsItemsModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/17.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


@objcMembers
class LiveBillboardsItemsModel: NSObject {
    
    // MARK: - 模型数组
    
    /// 用于存储转换完成的模型数据
    lazy var userInfoModelArray = [LiveBillboardsItemsUserInfoModel]()
    
    
    
    // MARK: - 服务器返回的模型数据
    
    /// type
    var type: String = ""
    
    /// id
    var id: Int = 0
    
    /// title
    var title: String = ""
    
    /// 用户头像数据items
    var items: [[String: Any]]? {
        
        didSet {
            
            // 校验items是否有值
            guard let items = items else { return }
            
            // 遍历数组items，取出字典
            for dict in items {
                
                // 将字典转为模型
                let item = LiveBillboardsItemsUserInfoModel(dict: dict)
                
                // 将转换完成的模型数据保存到与之对应的模型数组中
                userInfoModelArray.append(item)
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
