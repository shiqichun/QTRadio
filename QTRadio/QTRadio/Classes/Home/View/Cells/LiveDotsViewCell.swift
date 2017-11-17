//
//  LiveDotsViewCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/17.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class LiveDotsViewCell: UICollectionViewCell {
    
    // MARK: - 私有属性
    
    
    
    // MARK: - 懒加载属性
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




// MARK: - 设置UI界面
extension LiveDotsViewCell {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置cell的圆角
        layer.cornerRadius = 5
        layer.masksToBounds = true
        backgroundColor = UIColor.randomColor()
        
        
    }
}
