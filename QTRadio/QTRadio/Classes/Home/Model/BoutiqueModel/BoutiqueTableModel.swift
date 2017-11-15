//
//  BoutiqueTableModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/15.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


@objcMembers
class BoutiqueTableModel: NSObject {
    
    
    // MARK: - 模型数组
    
    /// 用于保存转换完成的模型数据
    lazy var tableRecommendModeArray = [BoutiqueTableRecommendsModel]()
    
    
    // MARK: - 服务器返回的模型属性
    
    /// headerView上面的标题
    var name: String = ""
    
    /// 简介
    var brief_name: String = ""
    
    /// 数组中的字典数据
    var recommends: [[String: Any]]? {
        
        didSet {
            // 校验数组recommends中是否有数据
            guard let recommends = recommends else { return }
            
            // 遍历数组recommends，取出它里面的字典
            for dict in recommends {
                
                // 将字典转为模型
                let item = BoutiqueTableRecommendsModel(dict: dict)
                
                // 将转换完成的模型数据保存起来
                self.tableRecommendModeArray.append(item)
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
