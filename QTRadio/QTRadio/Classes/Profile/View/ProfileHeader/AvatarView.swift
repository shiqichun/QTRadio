//
//  AvatarView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/8.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class AvatarView: UIView {

    
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
extension AvatarView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置背景颜色
        backgroundColor = .white
    }
}
