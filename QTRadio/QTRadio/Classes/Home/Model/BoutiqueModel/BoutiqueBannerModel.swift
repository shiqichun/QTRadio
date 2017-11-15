//
//  BoutiqueBannerModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/15.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


@objcMembers
class BoutiqueBannerModel: NSObject {
    
    // MARK: - 模型数组
    
    /// 用于保存已经转换完成的模型数据
    lazy var bannerRecommendsModelArray = [BoutiqueBannerRecommendsModel]()
    
    
    // MARK: - 服务器返回的模型属性
    
    
    /// 数组里面存放的是字典数据
    var recommends:[[String: Any]]? {
        
        didSet {
            
            // 校验数组recommends是否有值
            guard let recommends = recommends else { return }
            
            // 遍历数组recommends，取出它里面的字典
            for dict in recommends {
                
                // 将字典转为模型
                let item = BoutiqueBannerRecommendsModel(dict: dict)
                
                // 将转换完成的模型数组保存起来
                bannerRecommendsModelArray.append(item)
            }
        }
    }
    
    /// 序列
    var sequence: Int = 0
    
    /// 名称
    var brief_name: String = ""
    
    /// 类别
    var name: String = ""
    
    /// 分组号
    var section_id: Int = 0
    
    
    
    // MARK: - 自定义构造函数

    /// 将字典转为模型
    init(dict: [String: Any]) {
        super.init()
        
        // 利用KVC将字典转为模型
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
