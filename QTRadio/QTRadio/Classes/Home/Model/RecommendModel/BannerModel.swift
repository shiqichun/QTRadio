//
//  BannerModel.swift
//  多层嵌套JSON
//
//  Created by Enrica on 2017/11/13.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


@objcMembers
class BannerModel: NSObject {
    
    // MARK: - 自定义的模型数组
    
    /// 用于存储转换完成的模型数据
    lazy var bannerDataModelArray: [BannerDataModel] = [BannerDataModel]()

    // MARK: - 服务器返回的模型属性
    
    
    /// 模块
    var type: String = ""
    
    /// 字典数据 - 它里面包含一个数组，
    /// 而这个数组中又包含字典，我们需
    /// 要接着将其转为模型
    var data: [String: Any]? {
        
        didSet {
            
            // 首先对字典data中的数据进行校验
            guard let data = data else { return }
            
            // 接着将字典转为模型
            let item = BannerDataModel(dict: data)
            
            // 将转换完成的模型数据存储到数组中
            bannerDataModelArray.append(item)
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
