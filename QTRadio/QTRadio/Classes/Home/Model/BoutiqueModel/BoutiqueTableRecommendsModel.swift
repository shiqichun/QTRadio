//
//  BoutiqueTableRecommendsModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/15.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit



@objcMembers
class BoutiqueTableRecommendsModel: NSObject {
    
    // MARK: - 模型数组
    
    /// 用于存储转换完成的模型数据
    lazy var tableParentInfoModelArray = [BoutiqueTableParentInfoModel]()

    
    // MARK: - 服务器返回的模型属性
    
    /// 配图地址
    var thumb: String = ""
    
    /// 子标题
    var title: String = ""
    
    /// 主标题字典
    var parent_info: [String: Any]? {
        
        didSet {
            
            // 校验字典parent_info是否有值
            guard let parent_info = parent_info else { return }
            
            // 将字典转为模型
            let item = BoutiqueTableParentInfoModel(dict: parent_info)
            
            // 将转换完成的模型数据保存起来
            tableParentInfoModelArray.append(item)
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
