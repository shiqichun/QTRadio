//
//  ProfileCellModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/8.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class ProfileCellModel: NSObject {

    // MARK: - 模型属性
    
    /// cell中的图片
    var cellImageName: String = ""
    
    /// cell中的标题
    var cellTitle: String = ""
    
    /// cell的副标题
    var cellSubtitle: String = ""
    
    
    
    
    // MARK: - 自定义构造函数
    
    /// 根据图片名称、标题创建对应的cell模型
    /// - 参数cellImageName：表示cell的配图
    /// - 参数cellTitle：表示cell的主标题
    /// - 参数cellSubtitle：表示cell的副标题
    init(cellImageName: String, cellTitle: String, cellSubtitle: String = "") {
        
        // 初始化私有属性
        self.cellImageName = cellImageName
        self.cellTitle = cellTitle
        if cellSubtitle != "" {
            self.cellSubtitle = cellSubtitle
        }
    }
    
    
    
//    override init() {
//
//    }
    
    
//    init(dict: [String: Any]) {
//        super.init()
//
//        setValuesForKeys(dict)
//    }
    
    
//    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
}
