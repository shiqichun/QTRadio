//
//  HotWordGridModel.swift
//  多层嵌套JSON
//
//  Created by Enrica on 2017/11/13.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


@objcMembers
class HotWordGridModel: NSObject {
    
    // MARK: - 自定义的模型数组
    
    /// 将转换完成的模型属性存储起来
    lazy var hotWordGridDataModelArray: [HotWordGridDataModel] = [HotWordGridDataModel]()
    
    // MARK: - 服务器返回的模型属性
    
    
    /// 类型
    var type: String = ""
    
    /// 字典数据
    var data: [String: Any]? {
        
        didSet {
            
            // 先对字典data中的数据进行校验
            guard let data = data else { return }
            
            // 直接将字典data转为模型
            let item = HotWordGridDataModel(dict: data)
            
            // 将转换完成的模型数据存储到数组中
            hotWordGridDataModelArray.append(item)
        }
    }
    
    
    // MARK: - 自定义构造函数
    
    /// 字典转模型
    init(dict: [String: Any]) {
        super.init()
        
        // 利用KVC将字典转为模型
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
