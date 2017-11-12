//
//  CategoryTopViewModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/12.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

@objcMembers
class CategoryTopViewModel: NSObject {

    /// imageView
    var imageName: String = ""
    
    /// title
    var title: String = ""
    
    /// 是否需要隐藏imageView
    var isImageViewHidden: Bool = false
    
    /// 是否需要隐藏分割线
    var isSeperateLineHidden: Bool = false
    
    /// 是否需要红色遮盖
    var isNeedRedCover: Bool = false
    
    /// 是否需要蓝色遮盖
    var isNeedBlueCover: Bool = false 
    
    /// 构造函数
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
